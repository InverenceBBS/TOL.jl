# define accessor functions
core(AF::F) where {F<:AtomicFechado} = AF.core
n(AF::F) where {F<:AtomicFechado} = n(core(AF))
range(AF::F) where {F<:AtomicFechado} = range(core(AF))
f_is_in(AF::F) where {F<:AtomicFechado} = f_is_in(core(AF))

# define equality
==(a::T, b::T) where T <: Atomic =
    getfield.(Ref(a),fieldnames(T)) == getfield.(Ref(b),fieldnames(T))
==(a::T, b::T) where T <: AtomicFechado =
    a.core == b.core
## notice that here we could also define an equality for AtomicFechados of different type and composites

struct IntFechados <: AbstractFechado
    fechados::Array{<:AbstractFechado}
end

∈(a_date::Tt,a_IntFechado::IntFechados) where {Tt <: TimeType} = all(a_date .∈ a_IntFechado.fechados)

struct UnFechados <: AbstractFechado
    fechados::Array{<:AbstractFechado}
end

∈(a_date::Tt,a_UnFechados::UnFechados) where {Tt <: TimeType} = any(a_date .∈ a_UnFechados.fechados)

∩(f::F, l::L) where {F <: AbstractFechado, L <: AbstractFechado} = IntFechados([f,l])
∪(f::F, l::L) where {F <: AbstractFechado, L <: AbstractFechado} = UnFechados([f,l])

function C(a_Fechado::F) where {F<:AtomicFechado}
    this_range = range(a_Fechado)[range(a_Fechado) .!= n(a_Fechado)]
    return UnFechados([F(k) for k in this_range])
end

function succ(T::AtomicFechado,k)
    new_n = mod((n(T) + k),maximum(range(T)))
    new_n = new_n < minimum(range(T)) ? maximum(range(T)) : new_n
    return typeof(T)(new_n)
end

-(f::F, l::L) where {F <: AbstractFechado, L <: AtomicFechado} = f ∩ C(l)


prec(a_date::Tt,Type::D,k) where {D <: AtomicFechado, Tt <: TimeType} = succ(a_date,Type,-k)
prec(Type::D,a_date::Tt,k) where {D <: AtomicFechado, Tt <: TimeType} = succ(Type,a_date,-k)
prec(Type::D,k) where D <: AtomicFechado = succ(Type,-k)

## sugarcoating things, e.g., custom pretty print

Base.show(io::IO, z::AF) where {AF<:AtomicFechado} = print(io, typeof(z),"(",n(z),")")
Base.show(io::IO, ::MIME"text/plain", z::AF) where {AF<:AtomicFechado} =
           print(io, typeof(z),":\n n = ",
           n(z), "\n range =",
           range(z), "\n comparison function =",
           f_is_in(z))