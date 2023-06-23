module TOL

using Dates
import Base: ∈
import Base: ∩
import Base: ∪ 
import Base: -

## Declaration of types and structs for temporal settings

abstract type AbstractFechado end

abstract type AtomicFechado <: AbstractFechado end

function ∈(a_date::Tt,FeAt::AF)::Bool where {Tt<:TimeType, AF<:AtomicFechado}
    is_in = f_is_in(FeAt)(a_date) == n(FeAt) ? true : false
    return is_in
end

export Day_of_Month
include("Fechados/Day_of_Month.jl")

export Day_of_Week
include("Fechados/Day_of_Week.jl")

export Month_of_Year
include("Fechados/Month_of_Year.jl")

## Declaration of operators and composed temporal types

export IntFechados
export UnFechados
export ∈
export ∩
export ∪
export succ
export prec
include("Utilities.jl")

end
