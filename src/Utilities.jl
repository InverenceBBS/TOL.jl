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


prec(a_date::Tt,Type::D,k) where {D <: AbstractFechado, Tt <: TimeType} = succ(a_date,Type,-k)
prec(Type::D,a_date::Tt,k) where {D <: AbstractFechado, Tt <: TimeType} = succ(Type,a_date,-k)
prec(Type::D,k) where D <: AbstractFechado = succ(Type,-k)