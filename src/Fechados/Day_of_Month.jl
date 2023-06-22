struct Day_of_Month <: AbstractFechado
    n::Int
    Day_of_Month(n) = n > 31 || n < 0 ? error("The day of the month can not be negative nor greater than 31") : new(n)
end

function ∈(a_date::Date,a_Day_of_Month::Day_of_Month)::Bool
    is_in = dayofmonth(a_date) == a_Day_of_Month.n ? true : false
    return is_in
end

succ(a_date::Date,T::Day_of_Month,k) = a_date + Day(k)

function succ(T::Day_of_Month,k)
    new_n = mod((T.n + k),31)
    new_n = new_n == 0 ? 31 : new_n
    return Day_of_Month(new_n)
end

function succ(T::Day_of_Month,a_date::Date,k)
    new_n = mod((T.n + k), daysinmonth(a_date))
    new_n = new_n == 0 ? daysinmonth(a_date) : new_n
    return Day_of_Month(new_n)
end