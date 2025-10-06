// Monopolistic Competition Model with Flexible Prices
// Adjusted for habit persistence h = 0.4

global num_procs
num_procs = 1;
var c n y w i a nu r pi;
varexo eps_a eps_i;

parameters alpha, rho, theta, varphi, eta_a, phi, eta_i, epsilon, mu, piast, h;

alpha = 0.3;                // production function
rho = 0.01;                 // time preference rate
varphi = 1;                 // inverse Frisch elasticity
theta = 1;                  // inverse elasticity of intertemporal substitution
h = 0.4;                    // habit persistence parameter
eta_a = 0.9;                // TFP shock persistence
phi = 1.5;                  // Taylor rule coefficient
eta_i = 0.5;                // interest shock persistence
epsilon = 10;              
mu = epsilon/(epsilon-1);   // markup
piast = 0.02;               // inflation target

model;
a = eta_a*a(-1) + eps_a;
nu = eta_i*nu(-1) + eps_i;

exp(y) = exp(c);
exp(y) = exp(a)*(exp(n))^(1-alpha);

// Habit-adjusted Euler equation
1 / (exp(c) - h*exp(c(-1))) = (1 + pi(+1)) / (1 + rho) * (1 / (exp(c(+1)) - h*exp(c)));

exp(w) = (exp(c))^theta * (exp(n))^varphi;
exp(w) = (1-alpha)*exp(y)/(exp(n)*mu);

r = (1 + i)/(1 + pi(+1)) - 1;
1 + i = (1 + rho)*(1 + piast)*((1 + pi)/(1 + piast))^phi * exp(nu);
end;

initval;
a = 0;
c = 0.5;
n = 0.3;
y = 0.6;
w = 1.5;
r = 0.05;
i = 0.03;
pi = piast;
end;

steady;

shocks;
var eps_a; stderr 0.008;
var eps_i; stderr 0.003;
end;

stoch_simul(order=1, irf=20);
