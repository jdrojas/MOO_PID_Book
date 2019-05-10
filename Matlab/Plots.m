function Plots(Y)

    % 2-D in F-space
    if size(Y,1) == 2,
        plot(Y(1,:), Y(2,:), 'r*', Y(1,:), Y(2,:), 'b--');
        title('Pareto Front in F-space');
        xlabel('f_1');
        ylabel('f_2');
    % 3-D
    elseif size(Y,1) == 3,
      plot3(Y(1,:), Y(2,:), Y(3,:),'r*')
      title('Pareto Front in F-space');
      xlabel('f_1')
      ylabel('f_2')
      zlabel('f_3')
    end