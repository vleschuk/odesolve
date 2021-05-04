using DifferentialEquations
using Plots; gr()
H = <HAMILTONIAN>
f(u,p,t) = H*u - u*H
u0 = <START>
tspan = (0.0,1.0)
prob = ODEProblem(f,u0,tspan)
sol = solve(prob)
#pl1 = plot(sol)
#gui()
