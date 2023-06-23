using TOL
using Dates
using Test

@testset "Utilities" begin
    @test typeof(Month_of_Year(6) ∩ Day_of_Month(22)) == IntFechados
    @test typeof(Month_of_Year(6) ∪ Day_of_Month(22)) == UnFechados
    @test Date("2023-06-22") ∈ Month_of_Year(6) ∩ Day_of_Month(22)
    @test Date("2023-06-22") ∈ Month_of_Year(6) ∪ Day_of_Month(22)
end


@testset "Fechados" begin
    @test succ(Month_of_Year(1),2) == Month_of_Year(3)
    @test succ(Month_of_Year(1),-2) == Month_of_Year(11)
    @test prec(Month_of_Year(1),2) == succ(Month_of_Year(1),-2)

    @test succ(Day_of_Month(1),2) == Day_of_Month(3)
    @test succ(Day_of_Month(1),-2) == Day_of_Month(30)
    @test prec(Day_of_Month(1),2) == succ(Day_of_Month(1),-2)

    @test succ(Day_of_Week(1),2) == Day_of_Week(3)
    @test succ(Day_of_Week(1),-2) == Day_of_Week(6)
    @test prec(Day_of_Week(1),2) == succ(Day_of_Week(1),-2)
end
