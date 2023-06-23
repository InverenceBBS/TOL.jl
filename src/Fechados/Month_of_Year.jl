struct Month_of_Year <: AtomicFechado
    core::Atomic
end

Month_of_Year(n::N) where {N<:Int}  = Month_of_Year(Atomic(n, collect(1:1:12), month))

succ(a_date::Tt,T::Month_of_Year,k) where {Tt<:TimeType} = a_date + Month(k)