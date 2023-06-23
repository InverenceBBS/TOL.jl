struct Day_of_Week <: AtomicFechado
    core::Atomic
end

Day_of_Week(n) = Day_of_Week(Atomic(n, collect(1:1:7), dayofweek))

succ(a_date::Tt,T::Day_of_Week,k) where {Tt<:TimeType} = a_date + Day(k)