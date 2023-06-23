struct Month_of_Year <: AtomicFechado
    core::Atomic
end

function Day_of_Month(n::Int,
                      range = collect(1:1:12),
                      f_is_in = month)
    return Day_of_Month(Atomic(n,range,f_is_in))
end


succ(a_date::Tt,T::Month_of_Year,k) where {Tt<:TimeType} = a_date + Month(k)