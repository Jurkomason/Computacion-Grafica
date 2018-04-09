function [B]=RotacionY(A,alfa)
%alfa: angulo de rotacion contrario a la manecillas del reloj

alfa=degtorad(alfa);

MTransformacion = [cos(alfa)    0   sin(alfa)   0
                   0            1   0           0
                   -sin(alfa)   0   cos(alfa)   0
                   0            0   0           1];

B = MTransformacion*A';

return;
