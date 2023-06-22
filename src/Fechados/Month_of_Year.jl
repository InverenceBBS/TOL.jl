struct Month_of_Year <: AbstractFechado
    n::Int
    Month_of_Year(n) = n > 12 || n < 0 ? error("The month of the year can not be negative nor greater than 12") : new(n)
end

function ∈(a_date::Date,a_Month_of_Year::Month_of_Year)::Bool
    is_in = month(a_date) == a_Month_of_Year.n ? true : false
    return is_in
end

succ(a_date::Date,T::Month_of_Year,k) = a_date + Month(k)

function succ(T::Month_of_Year,k)
    new_n = mod((T.n + k),12)
    new_n = new_n == 0 ? 12 : new_n
    return Month_of_Year(new_n)
end