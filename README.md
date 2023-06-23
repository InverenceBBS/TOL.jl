# TOL

[![Build Status](https://github.com/gvdr/TOL.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/gvdr/TOL.jl/actions/workflows/CI.yml?query=branch%3Amain)

A quick and dirty implementation of TOL time representation, in pure Julia.

To install the yet unregistered packages 

```julia
using Pkg
Pkg.add("https://github.com/gvdr/TOL.jl")
```

## What's in the package

For the moment we have just some bare structures, types, and functions that come from the TOL ideas.

The **calendarization** is dynamic, and it is lifted from `Dates.TimeType`: this means that we can use `Date` (i.e., "2023-06-23"), `Time` (i.e., "12:33:08.336"), or `DateTime` (i.e., "2023-06-23T02:03:08.336").

There are, for the moments, three kinds of fechados, namely:
-   Day_of_Month: a `Day_of_Month(4)` includes all dates (or datetimes) that are on the 4th day of a month (i.e., all days like "yyyy-mm-04").
-   Day_of_Week: a `Day_of_Week(4)` includes all dates (or datetimes) that are on the 4th day of a week (i.e., Thursdays).
-   Month_of_Year:  a `Month_of_Year(4)` includes all dates (or datetimes) that are on the 4th Month of a year (i.e., April).

We have **operators** working on date (or datetimes) and fechados.
- ∈ : This is most fundamental operator, as it fundamentally defines the fechados, determing whether a certain date is in it or not. The converse operator ∋ comes for free 😄
- ∩ and ∪: creates respectively intersections and unions of fechados. The resulting objects are of type `IntFechado` and `UnFechado` respectively. Composition happens from the left: `Day_of_Week(1) ∩ Day_of_Month(1) ∩ Month_of_Year(1)` is the same of `((Day_of_Week(1) ∩ Day_of_Month(1)) ∩ Month_of_Year(1))`. We also have the convenience constructor functions `IntFechados()` and `UnFechados()` that work with arrays fechados (i.e., `IntFechados([Day_of_Week(1), Day_of_Month(1), Month_of_Year(1)])`).
- `succ()` and `prec()` : these functions returns either successors or predecessors of **dates** or **fechados**. The last argument is always compulsory, and it is the number of succ (or prec) steps to take.

## Examples

```julia
using TOL
using Dates

today = now()

today ∈ Day_of_Week(1) ∩ Day_of_Month(1) ∩ Month_of_Year(1)

today ∈ Day_of_Week(4) ∪ Day_of_Week(5)

succ(Month_of_Year(1),1)
prec(Month_of_Year(1),2)

succ(today,Month_of_Year(1),2)
```

## Extension

An atomic fechado is defined by three main object. The first two are mandatory:
- a **struct** inhering from `AtomicFechado`, that has the only field `core`:
    ```julia
    struct Day_of_Week <: AtomicFechado
        core::Atomic
    end
    ```
- a **constructor** for the atomic fechado, that provides the default information regarding the **range** and the **comparison function**, for example, to define an atomic fechado that considers the `dayofweek` of a date (or datetime) and has a range from 0 to 6, we write:
    ```julia
    Day_of_Week(n::N) where {N<:Int}  = Day_of_Week(Atomic(n, collect(1:1:7), dayofweek))
    ```
    In general, a `range` and `n` can be defined using whatever number (in this example we forec `n` to be an integer). The comparison function defines the inclusion by determining whether `comparison_function(a_date) == n`, and can be any of the `Dates` functions or user defined.
- **optionally**, a collection of `succ()` functions, determing what is the next date, when considering it as an element of a certain atomic fechado. For example:
    ```julia
    succ(a_date::Tt,T::Day_of_Week,k) where {Tt<:TimeType} = a_date + Day(k)
    ```
    The general successor function for the *class* of any defined Atomic Fechados is defined in  `src/Utilities.jl`; a method overriding it can be provided by a function of signature `function succ(T::ASF,k)` where `ASF` is the name of the user defined Atomic Fechado.

For convenience, we keep them all in `src/Fechados/`.