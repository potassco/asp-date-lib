
# An ASP Library for dates

* Dates are represented as tuple terms (D,M,Y).
* Library converts absolute dates into relative dates.
* Library finds out the weekday of a date.
* Library can create date tuples for every day in a given month or year.
* Day differences are realized using Julian Day Numbers, see http://quasar.as.utexas.edu/BillInfo/JulianDatesG.html .
* Week days are realized using a formula from https://de.wikipedia.org/wiki/Wochentagsberechnung



# Input Predicates

## date_consider_month/2( M, Y )

Creates all dates of the given month in the given year that need to be considered.

|Argument | Domain                     | Note          |
|:--------|:---------------------------|:--------------|
| M       | number (1-12)              | Month
| Y       | number (1XXX-2XXX)         | Year

## date_consider_year/2( Y )

Creates all dates of the given year that need to be considered.

|Argument | Domain                     | Note          |
|:--------|:---------------------------|:--------------|
| Y       | number (1XXX-2XXX)         | Year

## date_origin/1( (D,M,Y) )

Define the origin date for relative date computations.

Arguments are as with date_consider/1.

# Output Predicates

## date_consider/1( (D,M,Y) )

Dates that will be considered.
Do NOT use it to create dates! It allows the creation of illegal dates i.e. 29th of February on a non leap year.

|Argument | Domain                     | Note          |
|:--------|:---------------------------|:--------------|
| D       | number (1-31)              | Day of Month
| M       | number (1-12)              | Month
| Y       | number (1XXX-2XXX)         | Year

## date_julian/2( (D,M,Y), JulianDay )

Mapping from considered dates to Julian Day number (number of days since 1st of January -4712).

Remark: the "half day" of Julian Day computation is omitted. This preserves correctness of relative day counts.

|Argument   | Domain                     | Note          |
|:----------|:---------------------------|:--------------|
| D         | number (1-31)              | Day of Month
| M         | number (1-12)              | Month
| Y         | number (1XXX-2XXX)         | Year
| JulianDay | positive number            | Number of Days since 1st of January -4712

## date_relative/2( (D,M,Y), Days )

Mapping from considered dates to relative number of days with respect to the date given via date_origin.

|Argument | Domain                     | Note          | 
|:--------|:---------------------------|:--------------|
| D       | number (1-31)              | Day of Month
| M       | number (1-12)              | Month
| Y       | number (1XXX-2XXX)         | Year
| Days    | number (no restriction)    | Number of Days

## date_weekday/2( (D,M,Y), Weekday )

Mapping from considered dates to weekdays.

|Argument | Domain                     | Note          |
|:--------|:---------------------------|:--------------|
| D       | number (1-31)              | Day of Month
| M       | number (1-12)              | Month
| Y       | number (1XXX-2XXX)         | Year
| Days    | number (0-6)               | Weekday

Weekdays are as follows: 0/Monday, ..., 6/Sunday

## last_date_month/3( D,M,Y )

Gives the last date of a given month and year. 

|Argument | Domain                     | Note          |
|:--------|:---------------------------|:--------------|
| D       | number (1-31)              | Day of Month
| M       | number (1-12)              | Month
| Y       | number (1XXX-2XXX)         | Year


