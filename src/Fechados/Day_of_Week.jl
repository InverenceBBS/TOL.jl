struct Day_of_Week <: AbstractFechado
    n::Int
    Day_of_Week(n) = n > 7 || n < 0 ? error("The day of the week can not be negative nor greater than 7") : new(n)
end

function ∈(a_date::Date,a_Day_of_Week::Day_of_Week)::Bool
    is_in = dayofweek(a_date) == a_Day_of_Week.n ? true : false
    return is_in
end

succ(a_date::Date,T::Day_of_Week,k) = a_date + Day(k)

function succ(T::Day_of_Week,k)
    new_n = mod((T.n + k),7)
    new_n = new_n == 0 ? 7 : new_n
    return Day_of_Week(new_n)
end