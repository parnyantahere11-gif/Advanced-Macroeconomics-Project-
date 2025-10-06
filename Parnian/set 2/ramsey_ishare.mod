
// ramsey_ishare.mod
// Ramsey Growth Model with Investment Share and varying ρ

var k c y i ishare;
parameters alpha delta rho z a n theta;

alpha = 0.3;
delta = 0.02;
rho   = 0.05;    // Initial value; overwritten in MATLAB loop
z     = 1;
a     = 0.02;
n     = 0.01;
theta = 2;

model;
  y = z * k^alpha;
  i = (n + a + delta) * k;
  c = y - i;
  ishare = i / y;

  // Steady-state Euler equation from lecture (k* condition)
  z * alpha * k^(alpha - 1) = (1 + rho) * (1 + a)^theta - (1 - delta);
end;

initval;
  k = 10;
  c = 2;
  y = 5;
  i = 1;
  ishare = 0.2;
end;

steady;
