using OrdinaryDiffEq, ModelingToolkit
using CSV, DataFrames
using SBML

# demo to compose two SBML models 
dir = joinpath(@__DIR__, "../data/")
fn1 = "BIOMD0000000332.xml" 
fn2 = "MODEL1705170005.xml"
fns = joinpath.(dir, [fn1, fn2])
ms = readSBML.(fns)
sys1, sys2 = ODESystem.(ms)
connections = [sys1.TF_VIIa_IX_l ~ 2*sys2.MMP13_mRNA]
@named connected = ODESystem(connections; systems=[sys1,sys2])
