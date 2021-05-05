using DifferentialEquations
using Plots; gr()
H = <HAMILTONIAN> :: Array{Complex{Float64},2}
f(u,p,t) = im*(u*H - H*u)
u0 = <START> :: Array{Complex{Float64},2}
tspan = (0.0,1.0)
prob = ODEProblem(f,u0,tspan)
sol = solve(prob)
#pl1 = plot(sol)
#gui()
