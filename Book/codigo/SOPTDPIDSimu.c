#include "mex.h"
#include<math.h>

/* A simple function to interpolate*/
void miniinterp1(double time[2], double x[2], double ti, double *xi){
    /* time is a vector of two components just as x*/
    if(time[0] == time[1]){ /* If itt is the same point, it gives the first value*/
        *xi=x[0];
    }
    else{
        *xi=x[0]+(x[1]-x[0])/(time[1]-time[0])*(ti-time[0]); /*Here is the interpolation*/
    }
}

/* Function that defines the model of the controlled system*/
void sistema(double t, double x[4], double *paramPlant, double *paramContr, double time[2], double r[2], double di[2], double dob[2], double y[2], double *dx){
    double k, tau, L, a, Kp, Ti, Td, alpha, beta, gamma;
    double Tdaux,rvalue,divalue,dovalue,yvalue;
    double ed,u;
    /*Plant*/
    k=paramPlant[0];
    tau=paramPlant[1];
    L=paramPlant[2];
    a=paramPlant[3];
    /*Controller*/
    Kp=paramContr[0];
    Ti=paramContr[1];
    Td=paramContr[2];
    alpha=paramContr[3];
    beta=paramContr[4];
    gamma=paramContr[5];
    
    if(Td==0){ /*If Td is zero, we need to be careful */
        Tdaux=0;
    }
    else{
        Tdaux=1;
    }
    
    /*algebraic equations*/
    miniinterp1(time, r, t, &rvalue); /* value of r at time t*/
    miniinterp1(time, di, t, &divalue);  /* value of di at time t*/
    if(L==0){
        miniinterp1(time, dob, t, &dovalue); /* value of di at time t*/
        yvalue=k*x[0]+dovalue;
    }
    else{
        miniinterp1(time, y, t, &yvalue); /*Delay is applied in the simulation function */
    }
    ed=gamma*rvalue-yvalue;
    u=Kp*(beta*rvalue-yvalue+1/Ti*x[2]+Tdaux/alpha*(ed+x[3]))+divalue;
    
    /*Differential equations*/
    if(a==0){
        dx[0]=-1/tau*x[0]+1/tau*u;
        dx[1]=0;
    }
    else{
        dx[0]=x[1];
        dx[1]=-1/(a*tau*tau)*x[0]-(1+a)/(a*tau)*x[1]+1/(a*tau*tau)*u;
    }
    dx[2]=rvalue-yvalue;
    if(Td==0){
        dx[3]=Tdaux;
    }
    else{
        dx[3]=-(1/(alpha*Td)*ed+1/(alpha*Td)*x[3]);
    }
}

/* Function that simulates the system*/
void simulacion(double *ydelay, double *x, double *u, double *ParamPlant, double *ParamContr, double *time, double *r, double *di, double *dob, double *x0, size_t mrows, double *y)
{
    /*Size of vectors:
     *y,ydelay,u,time,r,di,dob= mrowsx1
     *x=mrowsx4
     *ParamPlant 4x1
     *ParamContr 6x1
     *x0 4x1
     */
    /*Variables declaration*/
    double k, tau, L, a, Kp, Ti, Td, alpha, beta, gamma; /*Parameters of the system and controller*/
    double Tdaux, paso, yauxLvalue;
    double timeaux[2],yaux[2],raux[2],diaux[2],doaux[2],yauxL[2],posaux[2];
    double t,ed;
    int aux, posL, posR;
    double dx[4], state[4], x0aux[4], x0aux2[4], F1[4], F2[4], F3[4], F4[4], xnew[4];
    int i,j;
    mxArray *ymx;

    /*System simulation*/
    /*Parameters*/
    /*Plant*/
    k=ParamPlant[0];
    tau=ParamPlant[1];
    L=ParamPlant[2];
    a=ParamPlant[3];
    /*Controller*/
    Kp=ParamContr[0];
    Ti=ParamContr[1];
    Td=ParamContr[2];
    alpha=ParamContr[3];
    beta=ParamContr[4];
    gamma=ParamContr[5];
    /*Inicialization*/
    for(i=0;i<4;i++){
        x0aux[i]=x0[i];
    }
    if(Td==0){
        Tdaux=0;
    }
    else{
        Tdaux=1;
    };
    paso=(time[mrows-1]-time[0])/(mrows-1);
    for(i=0;i<mrows;i++){
        y[i]=0;
    };
    
    if(L==0){
        y[0]=k*x0[0]+dob[0];
        ydelay[0]=y[0];
    }
    else{
        y[0]=k*x0[0];
        ydelay[0]=dob[0];
    };
    for(j=0;j<4;j++){
          x[mrows*j]=xnew[j]; /*update of x*/
        };
    ed=gamma*r[0]-ydelay[0]; /*"error" for the derivative part */
    u[0]=Kp*(beta*r[0]-ydelay[0]+1/Ti*x0[2]+Tdaux/alpha*(ed+x0[3])); /* Computation of the initial control action*/
   
    
    /* Here the numerical integration starts*/
    for(i=1;i<mrows;i++){
        /* The output is delayed*/
        if(L!=0){
            if(time[i]<=L){
                ydelay[i]=dob[i]; /* If the time is less than the dead time, at the output we only see the output disturbance*/
            }
            else{
                if(L>=paso){ /* If L is larger or equal to the integration step, we make an interpolation, for the case the dead time is not*/
                    posL=floor(i-L/paso); /* an integer multiple of the integration step */
                    posR=posL+1;
                    yauxL[0]=y[posL];
                    yauxL[1]=y[posR];
                    posaux[0]=posL;
                    posaux[1]=posR;
                    miniinterp1(posaux, yauxL, i-L/paso, &yauxLvalue);
                    ydelay[i]=yauxLvalue+dob[i];
                }
                else{
                    ydelay[i]=y[i-1]+dob[i];
                };
                
            };
        };
        /* The 4th order Runge-Kutta method (RK4) is used*/
        /* The simple interpolation function aonly receives two values
         * therfore, we need to take the data in the last sample and the currrent sample
         */
        t=time[i-1];
        timeaux[0]=time[i-1];
        timeaux[1]=time[i];
        raux[0]=r[i-1];
        raux[1]=r[i];
        diaux[0]=di[i-1];
        diaux[1]=di[i];
        doaux[0]=dob[i-1];
        doaux[1]=dob[i];
        yaux[0]=ydelay[i-1];
        yaux[1]=ydelay[i];
        
        /* RK4 need to evaluate the differential equations four
         * times to make and approximation of the integrals.
         */
        /* First evaluation*/
        sistema(t, x0aux, ParamPlant, ParamContr, timeaux, raux, diaux, doaux, yaux, F1);
        /* Second evaluation*/
        for(j=0;j<4;j++){
            x0aux2[j]=x0aux[j]+0.5*paso*F1[j];
        }
        sistema(t+0.5*paso, x0aux2, ParamPlant, ParamContr, timeaux, raux, diaux, doaux, yaux, F2);
        /*Third evaluation*/
        for(j=0;j<4;j++){
            x0aux2[j]=x0aux[j]+0.5*paso*F2[j];
        }
        sistema(t+0.5*paso, x0aux2, ParamPlant, ParamContr, timeaux, raux, diaux, doaux, yaux, F3);
        /*Fourth evaluation*/
        for(j=0;j<4;j++){
            x0aux2[j]=x0aux[j]+paso*F3[j];
        }
        sistema(t+paso, x0aux2, ParamPlant, ParamContr, timeaux, raux, diaux, doaux, yaux, F4);
        /*Nuevos vaues of the states*/
        for(j=0;j<4;j++){
            xnew[j]=x0aux[j]+(paso/6)*(F1[j]+2*F2[j]+2*F3[j]+F4[j]);
        };
        /* State in the next iteration*/
        for(j=0;j<4;j++){
            x0aux[j]=xnew[j];
            x[i+mrows*j]=xnew[j]; /*update of x*/
        };
        /* x is a matrix, the size is given from the main function
         * but here it is NOT defined as a two-dimensional pointer, so
         * addressing should be done one-dimensionally. When
         * the matrix is filled, it is completed by columns, 
         * but the values we have correspond to the value in position
         * i for column j, therefore, the addressing must be done as above.       
         */
        
        /* Final computations (Plant output and controller output */
        if(L==0){
            y[i]=k*x0aux[0]+dob[i];
            ydelay[i]=y[i]; /*Output of  the plant (without delay)*/
        }
        else{
            y[i]=k*x0aux[0]; /*Output of the system (it is delayed below)*/
        };
        ed=gamma*r[i]-ydelay[i]; /* derivative part */
        u[i]=Kp*(beta*r[i]-ydelay[i]+1/Ti*x0aux[2]+Tdaux/alpha*(ed+x0aux[3])); /* Control action*/
    }
}

/* Main function, it creates  the interface between MATLAB and the functions in C*/
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[] )
{
    double *ParamPlant,*ParamContr,*time,*r,*di,*dob,*x0, *y, *u, *x;
    int i;
    size_t mrows,ncols;
    mxArray *ymx;
    double *ym;
    
    /* all vectors have the same size as the time vector*/
    mrows = mxGetM(prhs[2]);
    ncols = mxGetN(prhs[2]);
    
    /* The pointer of the function outputs are created. It returns the outputs in this order: y,x,u*/
  plhs[0] = mxCreateDoubleMatrix((mwSize)mrows, (mwSize)ncols, mxREAL);
  plhs[1] = mxCreateDoubleMatrix((mwSize)mrows, (mwSize)4, mxREAL);
  plhs[2] = mxCreateDoubleMatrix((mwSize)mrows, (mwSize)ncols, mxREAL);
  
  /*The function mxCreateDoubleMatrix helps to createthe output vectors,
   *with the same size as the time vector. It can handle any vector size
   */
  
  /* Pointer of the inputs */
  ParamPlant = mxGetPr(prhs[0]); /*Pointers of the plant parameters*/
  ParamContr = mxGetPr(prhs[1]); /*Pointer of the controller parameters*/
  time = mxGetPr(prhs[2]); /*Pointer to the simulation time*/
  r = mxGetPr(prhs[3]); /*Pointer to the setpoint vector*/
  di = mxGetPr(prhs[4]); /*Pointer to the input disturbance vector*/
  dob = mxGetPr(prhs[5]); /*Pointer to the output disturbance vector*/
  x0 = mxGetPr(prhs[6]); /*Pointer to the initial state*/
  
  /*Pointers to the outputs*/
  y = mxGetPr(plhs[0]);
  x = mxGetPr(plhs[1]);
  u = mxGetPr(plhs[2]);
  ymx = mxCreateDoubleMatrix((mwSize)mrows, (mwSize)1, mxREAL);
  ym = mxGetPr(ymx);
  /* And here the magic starts */
  simulacion(y,x,u,ParamPlant,ParamContr,time,r,di,dob,x0,mrows,ym);
}
