struct Atomic <: Atomic
    n::Number
    range::Vector{<:Number}
    f_is_in::Function
    Atomic(n,range, f_is_in) = n ∈ range ? new(n,range, f_is_in) : error("n must be in the range")
end

n(Atomic::Atomic) = Atomic.n
range(Atomic::Atomic) = Atomic.range
f_is_in(Atomic::Atomic) = Atomic.f_is_in