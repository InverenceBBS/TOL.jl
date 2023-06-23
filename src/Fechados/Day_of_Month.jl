struct Day_of_Month <: AtomicFechado
    core::Atomic
end

Day_of_Month(n) = Day_of_Month(Atomic(n, collect(1:1:31), dayofmonth))

succ(a_date::Tt,T::Day_of_Month,k) where {Tt<:TimeType} = a_date + Day(k)

function succ(T::Day_of_Month,a_date::Tt,k) where {Tt<:TimeType}
    new_n = mod((n(T) + k), daysinmonth(a_date))
    new_n = new_n == 0 ? daysinmonth(a_date) : new_n
    return Day_of_Month(new_n)
end