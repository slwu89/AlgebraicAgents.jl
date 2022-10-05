using AlgebraicAgents

# provide integration of AgentBasedModel, incl. AbstractAgent
add_integration(:AgentsIntegration); using AgentsIntegration

# SIR agent based model (ABM) model constructors, evolutionary functions
include("sir_agents_model.jl")

# create a sample agent based model
params = create_params(C = 8, max_travel_rate = 0.01)
abm = model_initiation(; params...)

infected(x) = count(i == :I for i in x)
recovered(x) = count(i == :R for i in x)
to_collect = [(:status, f) for f in (infected, recovered, length)]

m = ABMAgent("sir_model", abm; agent_step!, tspan=(0., 50.), adata=to_collect)

first(m.inners)[2].agent

# solving the problems
sol = simulate(m)