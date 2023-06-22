struct IntFechados <: AbstractFechado
    fechados::Array{<:AbstractFechado}
end

∈(a_date::Date,a_IntFechado::IntFechados)::Bool = all(a_date .∈ a_IntFechado.fechados)

struct UnFechados <: AbstractFechado
    fechados::Array{<:AbstractFechado}
end

∈(a_date::Date,a_UnFechados::UnFechados)::Bool = any(a_date .∈ a_UnFechados.fechados)

∩(f::F, l::L) where {F <: AbstractFechado, L <: AbstractFechado} = IntFechados([f,l])
∪(f::F, l::L) where {F <: AbstractFechado, L <: AbstractFechado} = UnFechados([f,l])


prec(a_date::Date,Type::D,k) where D <: AbstractFechado = succ(a_date,Type,-k)
prec(Type::D,a_date::Date,k) where D <: AbstractFechado = succ(Type,a_date,-k)
prec(Type::D,k) where D <: AbstractFechado = succ(Type,-k)