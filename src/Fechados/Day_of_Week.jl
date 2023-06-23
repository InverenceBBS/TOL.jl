struct Day_of_Week <: AtomicFechado
    core::Atomic
end

function Day_of_Month(n::Int,
                      range = collect(1:1:7),
                      f_is_in = dayofweek)
    return Day_of_Month(Atomic(n,range,f_is_in))
end

succ(a_date::Tt,T::Day_of_Week,k) where {Tt<:TimeType} = a_date + Day(k)