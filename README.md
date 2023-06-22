# TOL

[![Build Status](https://github.com/gvdr/TOL.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/gvdr/TOL.jl/actions/workflows/CI.yml?query=branch%3Amain)

A quick and dirty implementation of TOL time representation, in pure Julia.

To install the yet unregistered packages 

```julia
julia>] add https://github.com/gvdr/TOL.jl
```

## What's in the package

For the moment we have just some bare structures, types, and functions that come from the TOL ideas.

The **calendarization** is dynamic, and it is lifted from `Dates.TimeType`: this means that we can use `Date` (i.e., "2023-06-23"), `Time` (i.e., "12:33:08.336"), or `DateTime` (i.e., "2023-06-23T02:03:08.336").

There are, for the moments, three kinds of fechados, namely:
-   Day_of_Month: a `Day_of_Month(4)` includes all dates (or datetimes) that are on the 4th day of a month (i.e., all days like "yyyy-mm-04").
-   Day_of_Week: a `Day_of_Week(4)` includes all dates (or datetimes) that are on the 4th day of a week (i.e., Thursdays).
-   Month_of_Year:  a `Month_of_Year(4)` includes all dates (or datetimes) that are on the 4th Month of a year (i.e., April).

We have **operators** working on date (or datetimes) and fechados.
- ∈ : This is most fundamental operator, as it fundamentally defines the fechados, determing whether a certain date is in it or not.
- ∩ and ∩: creates respectively intersections and unions of fechados. The resulting objects are of type `IntFechado` and `UnFechado` respectively. Composition happens from the left: `Day_of_Week(1) ∩ Day_of_Month(1) ∩ Month_of_Year(1)` is the same of `((Day_of_Week(1) ∩ Day_of_Month(1)) ∩ Month_of_Year(1))`. We also have the convenience constructor functions `IntFechados()` and `UnFechados()` that work with arrays fechados (i.e., `IntFechados([Day_of_Week(1), Day_of_Month(1), Month_of_Year(1)])`).
- `succ()` and `prec()` : these functions returns either successors or predecessors of **dates** or **fechados**.