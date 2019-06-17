#include "mex.h"
#include<math.h>

/* Funcion reducida de interpolacion*/
void miniinterp1(double time[2], double x[2], double ti, double *xi){
    /* time es un vector de dos componentes al igual que x*/
    if(time[0] == time[1]){ /* Si es el mismo punto, se devuelve el primer valor*/
        *xi=x[0];
    }
    else{
        *xi=x[0]+(x[1]-x[0])/(time[1]-time[0])*(ti-time[0]); /*Acá se hace la interpolación*/
    }
}

/* Funcion que define el modelo del sistema controlado*/
void sistema(double t, double x[4], double *paramPlant, double *paramContr, double time[2], double r[2], double di[2], double dob[2], double y[2], double *dx){
    double k, tau, L, a, Kp, Ti, Td, alpha, beta, gamma;
    double Tdaux,rvalue,divalue,dovalue,yvalue;
    double ed,u;
    /*Planta*/
    k=paramPlant[0];
    tau=paramPlant[1];
    L=paramPlant[2];
    a=paramPlant[3];
    /*Controlador*/
    Kp=paramContr[0];
    Ti=paramContr[1];
    Td=paramContr[2];
    alpha=paramContr[3];
    beta=paramContr[4];
    gamma=paramContr[5];
    
    if(Td==0){ /*Si se pone un Td de cero, hay que tener un cuidado */
        Tdaux=0;
    }
    else{
        Tdaux=1;
    }
    
    /*Ecuaciones algebraicas*/
    miniinterp1(time, r, t, &rvalue); /* valor de r en el instante t*/
    miniinterp1(time, di, t, &divalue);  /* valor de di en el instante t*/
    if(L==0){
        miniinterp1(time, dob, t, &dovalue); /* valor de di en el instante t*/
        yvalue=k*x[0]+dovalue;
    }
    else{
        miniinterp1(time, y, t, &yvalue); /*El delay se aplica en la función simulacion */
    }
    ed=gamma*rvalue-yvalue;
    u=Kp*(beta*rvalue-yvalue+1/Ti*x[2]+Tdaux/alpha*(ed+x[3]))+divalue;
    
    /*Ecuaciones diferenciales*/
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

/* Funcion que hace la simulacion del sistema*/
void simulacion(double *ydelay, double *x, double *u, double *ParamPlant, double *ParamContr, double *time, double *r, double *di, double *dob, double *x0, size_t mrows, double *y)
{
    /*TamaÃ±o de los vectores:
     *y,ydelay,u,time,r,di,dob= mrowsx1
     *x=mrowsx4
     *ParamPlant 4x1
     *ParamContr 6x1
     *x0 4x1
     */
    /*Declaracion de variables*/
    double k, tau, L, a, Kp, Ti, Td, alpha, beta, gamma; /*Parametros del sistema y el controlador*/
    double Tdaux, paso, yauxLvalue;
    double timeaux[2],yaux[2],raux[2],diaux[2],doaux[2],yauxL[2],posaux[2];
    double t,ed;
    int aux, posL, posR;
    double dx[4], state[4], x0aux[4], x0aux2[4], F1[4], F2[4], F3[4], F4[4], xnew[4];
    int i,j;
    mxArray *ymx;
    /*double *y;
    ymx = mxCreateDoubleMatrix((mwSize)mrows, (mwSize)1, mxREAL);
    y = mxGetPr(ymx); ymx solo se utiliza para crear un vector de tamaño adecuado*/
    
    /*Sabemos que el tamanyo de y es mrows, pero no se puede crear
     directamente con double y[mrows] porque espera un valor constante. Por
     eso se utiliza mxCreateDoubleMatrix para que el tamanyo cambie al inicio
     de cada corrida del programa.     
     */
    
    
    /*Simulacion del sistema*/
    /*Parametros*/
    /*Planta*/
    k=ParamPlant[0];
    tau=ParamPlant[1];
    L=ParamPlant[2];
    a=ParamPlant[3];
    /*Controlador*/
    Kp=ParamContr[0];
    Ti=ParamContr[1];
    Td=ParamContr[2];
    alpha=ParamContr[3];
    beta=ParamContr[4];
    gamma=ParamContr[5];
    /*InicializaciÃ³n*/
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
        /*y[0]=k*(1/(1-a)*x0[0]-a/(1-a)*x0[1])+dob[0];*/
        y[0]=k*x0[0]+dob[0];
        ydelay[0]=y[0];
    }
    else{
        /*y[0]=k*(1/(1-a)*x0[0]-a/(1-a)*x0[1]);*/
        y[0]=k*x0[0];
        ydelay[0]=dob[0];
    };
    for(j=0;j<4;j++){
          x[mrows*j]=xnew[j]; /*actualizacion de x*/
        };
    ed=gamma*r[0]-ydelay[0]; /*"error" para la parte derivativa */
    u[0]=Kp*(beta*r[0]-ydelay[0]+1/Ti*x0[2]+Tdaux/alpha*(ed+x0[3])); /* Calculo de la accion de control inicial*/
   
    
    /* Inicia el metodo de integracion numerica*/
    for(i=1;i<mrows;i++){
        /* Se retarda la salida*/
        if(L!=0){
            if(time[i]<=L){
                ydelay[i]=dob[i]; /* Si no ha pasado un tiempo igual al retardo, lo unico que aparece a la salida es la perturbacion a la salida*/
            }
            else{
                if(L>=paso){ /* Si L es mas grande o igual que el paso, hacemos una interpolacion, para el caso que el retardo no sea*/
                    posL=floor(i-L/paso); /* un multiplo entero del paso de integracion */
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
                    /*Aqui es donde hay un problema. No se puede hacer una
                     * interpolacion, porque se necesitaria el valor de y en el
                     *paso i, pero no se tiene aun.Si el paso de integracion es pequeño
                     *pues el posible error no es importante. Por lo que
                     *se recomienda usar pasos pequeños. Si de todas maneras
                     *juegan de listos y no hacen esto... la solucion mas
                     *sencilla (no la mejor) es tomar el valor anterior con la
                     *perturbacion actual. En un futuro se puede hacer una extrapolacion
                     */
                };
                
            };
        };
        /*Se utiliza el metodo de Runge-Kutta de 4to orden*/
        /* La funcion simplificada de interpolacion, solo recibe dos valores
         * por lo que se tienen que tomar los datos del instante anterior y
         * actual
         */
        /* Esta parte se intento implementar con un for, pero el compilador
           no se dejo
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
        
        /* El metodo de RK4 necesita evaluar la ecuacion diferencial cuatro
         * veces para poder hacer una aproximacion de las integrales. En este
         * caso, ademas, tenemos un sistema con cuatro estados, por lo que
         * se estan resolviendo cuatro ODE's al mismo tiempo, pero que dependen
         * unas de otras
         */
        /* Primera evaluacion*/
        sistema(t, x0aux, ParamPlant, ParamContr, timeaux, raux, diaux, doaux, yaux, F1);
        /* Segunda evaluacion*/
        for(j=0;j<4;j++){
            x0aux2[j]=x0aux[j]+0.5*paso*F1[j];
        }
        sistema(t+0.5*paso, x0aux2, ParamPlant, ParamContr, timeaux, raux, diaux, doaux, yaux, F2);
        /*Tercera evaluacion*/
        for(j=0;j<4;j++){
            x0aux2[j]=x0aux[j]+0.5*paso*F2[j];
        }
        sistema(t+0.5*paso, x0aux2, ParamPlant, ParamContr, timeaux, raux, diaux, doaux, yaux, F3);
        /*Cuarta evaluacion*/
        for(j=0;j<4;j++){
            x0aux2[j]=x0aux[j]+paso*F3[j];
        }
        sistema(t+paso, x0aux2, ParamPlant, ParamContr, timeaux, raux, diaux, doaux, yaux, F4);
        /*Calculo de los nuevos estados*/
        for(j=0;j<4;j++){
            xnew[j]=x0aux[j]+(paso/6)*(F1[j]+2*F2[j]+2*F3[j]+F4[j]);
        };
        /* Estado de la siguiente iteracion*/
        for(j=0;j<4;j++){
            x0aux[j]=xnew[j];
            x[i+mrows*j]=xnew[j]; /*actualizacion de x*/
        };
        /* x es una matriz, el tamanyo viene dado de la funcion principal
         * pero aca NO se define como un puntero bidimensional, por eso
         * el direccionamiento se debe hacer unidimensionalmente. Cuando
         * se va rellenando la matriz, esta se va completando por columnas,
         * pero los valores que tenemos corresponden al valor en la posicion
         * i para la columna j, por lo tanto, hay que hacer el direccionamiento
         * como se hizo arriba         
         */
        
        /* Calculos finales (salida de la planta y salida del controlador */
        if(L==0){
            y[i]=k*x0aux[0]+dob[i];
            ydelay[i]=y[i]; /*Salida del sistema (sin retardo)*/
        }
        else{
            y[i]=k*x0aux[0]; /*Salida del sistema (se retarda despues)*/
        };
        ed=gamma*r[i]-ydelay[i]; /* La parte derivativa */
        u[i]=Kp*(beta*r[i]-ydelay[i]+1/Ti*x0aux[2]+Tdaux/alpha*(ed+x0aux[3])); /* La accion de control*/
    }
}

/* Funcion principal crea la interfaz entre MATLAB y las funciones en C */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[] )
{
    double *ParamPlant,*ParamContr,*time,*r,*di,*dob,*x0, *y, *u, *x;
    int i;
    size_t mrows,ncols;
    mxArray *ymx;
    double *ym;
    
    /* Todos los vectores tiene el mismo tamanyo que el tiempo*/
    mrows = mxGetM(prhs[2]);
    ncols = mxGetN(prhs[2]);
    
    /* Se crean los punteros de las salidas. Devuelve en este orden y,x,u*/
  plhs[0] = mxCreateDoubleMatrix((mwSize)mrows, (mwSize)ncols, mxREAL);
  plhs[1] = mxCreateDoubleMatrix((mwSize)mrows, (mwSize)4, mxREAL);
  plhs[2] = mxCreateDoubleMatrix((mwSize)mrows, (mwSize)ncols, mxREAL);
  
  /*La funcion mxCreateDoubleMatrix me ayuda a crear los vectores de las salidas,
   *con el mismo tamaÃ±o que el vector de tiempos. Sirve para cualquier tamanyo
   *de vector
   */
  
  /* Se obtienen los punteros de las entradas */
  ParamPlant = mxGetPr(prhs[0]); /*Puntero a los parAmetros de la planta*/
  ParamContr = mxGetPr(prhs[1]); /*Puntero a los parAmetros del controlador*/
  time = mxGetPr(prhs[2]); /*Puntero al tiempo de simulacion*/
  r = mxGetPr(prhs[3]); /*Puntero al vector de referencia*/
  di = mxGetPr(prhs[4]); /*Puntero al vector de perturbaciones a la entrada*/
  dob = mxGetPr(prhs[5]); /*Puntero al vector de perturbaciones a la salida*/
  x0 = mxGetPr(prhs[6]); /*Puntero al vector de estado inicial*/
  
  /*Punteros a las variables de salida*/
  y = mxGetPr(plhs[0]);
  x = mxGetPr(plhs[1]);
  u = mxGetPr(plhs[2]);
  ymx = mxCreateDoubleMatrix((mwSize)mrows, (mwSize)1, mxREAL);
  ym = mxGetPr(ymx);
  /*Aca es donde ocurre la magia */
  simulacion(y,x,u,ParamPlant,ParamContr,time,r,di,dob,x0,mrows,ym);
}