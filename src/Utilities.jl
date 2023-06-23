struct IntFechados <: AbstractFechado
    fechados::Array{<:AbstractFechado}
end

n(AF::F) where {F<:AtomicFechado} = n(core(AF))
range(AF::F) where {F<:AtomicFechado} = range(core(AF))
f_is_in(AF::F) where {F<:AtomicFechado} = f_is_in(core(AF))

∈(a_date::Tt,a_IntFechado::IntFechados) where {Tt <: TimeType} = all(a_date .∈ a_IntFechado.fechados)

struct UnFechados <: AbstractFechado
    fechados::Array{<:AbstractFechado}
end

∈(a_date::Tt,a_UnFechados::UnFechados) where {Tt <: TimeType} = any(a_date .∈ a_UnFechados.fechados)

∩(f::F, l::L) where {F <: AbstractFechado, L <: AbstractFechado} = IntFechados([f,l])
∪(f::F, l::L) where {F <: AbstractFechado, L <: AbstractFechado} = UnFechados([f,l])

function C(a_Fechado::F) where {F<:AtomicFechado}
    this_range = a_Fechado.range[a_Fechado.range .!= a_Fechado.n]
    return UnFechados([F(k) for k in this_range])
end

function succ(T::AtomicFechado,k)
    new_n = mod((n(T) + k),max(range(T)))
    return Day_of_Week(new_n)
end

-(f::F, l::L) where {F <: AbstractFechado, L <: AtomicFechado} = f ∩ C(l)


prec(a_date::Tt,Type::D,k) where {D <: AtomicFechado, Tt <: TimeType} = succ(a_date,Type,-k)
prec(Type::D,a_date::Tt,k) where {D <: AtomicFechado, Tt <: TimeType} = succ(Type,a_date,-k)
prec(Type::D,k) where D <: AtomicFechado = succ(Type,-k)