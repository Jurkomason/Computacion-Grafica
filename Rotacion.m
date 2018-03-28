function [B]=Rotacion(A,alfa)
%alfa: angulo de rotacion contrario a la manecillas del reloj

alfa=degtorad(alfa);

MTransformacion = [cos(alfa)    -sin(alfa)
                   sin(alfa)    cos(alfa)];

B = MTransformacion*A';

return;
