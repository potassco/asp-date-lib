%
% Julian Day Numbers
%

% March-December = start months of Julian year
date_julian((DIn,MIn,YIn),Julian) :-
  date_consider((DIn,MIn,YIn)),
  MIn >= 3,
  YEffective = YIn, % same year
  MEffective = MIn, % March = 3, December = 12
  A = YEffective / 100, % century
  B = A/4,
  C = 2-A+B,
  E = (36525*(YEffective+4716))/100,
  F = (306001*(MEffective+1))/10000,
  Julian = C+DIn+E+F-1525.

% January-February = end months of previous Julian year
date_julian((DIn,MIn,YIn),Julian) :-
  date_consider((DIn,MIn,YIn)),
  MIn < 3,
  YEffective = YIn-1, % previous year
  MEffective = MIn+12, % January = 13, February = 14
  A = YEffective / 100, % century
  B = A/4,
  C = 2-A+B,
  E = (36525*(YEffective+4716))/100,
  F = (306001*(MEffective+1))/10000,
  Julian = C+DIn+E+F-1525.

%
% weekday
%

% March-December = start months of Julian year
date_weekday((DIn,MIn,YIn),Weekday) :-
  date_consider((DIn,MIn,YIn)),
  MIn >= 3,
  YEffective = YIn, % same year
  C = YEffective / 100, % century
  Y = (YEffective-1900) \ 100, % year relative to 1900
  M = MIn-2, % March = 1, December = 10
  Weekday = (((DIn + (13*M-1)/5 + Y + Y/4 + C/4 - 2*C - 1) \ 7) + 7) \ 7.

% January-February = end months of previous Julian year
date_weekday((DIn,MIn,YIn),Weekday) :-
  date_consider((DIn,MIn,YIn)),
  MIn < 3,
  YEffective = YIn-1, % previous year
  C = YEffective / 100, % century
  Y = (YEffective-1900) \ 100, % year relative to 1900
  M = MIn+10, % January = 11, February = 12
  Weekday = (((DIn + (13*M-1)/5 + Y + Y/4 + C/4 - 2*C - 1)\ 7) + 7) \ 7.

%
% relative day numbers
%

% julian day of origin
date_consider((D,M,Y)) :- date_origin((D,M,Y)).
date_relative((D,M,Y),Julian-OJulian) :-
  date_julian((D,M,Y),Julian),
  date_origin((OD,OM,OY)),
  date_julian((OD,OM,OY),OJulian).

%
% Calculate leap years 
%

calc_leap_year(YYYY) :- date_consider_month(2,YYYY).

is_leap_year(YYYY) :- calc_leap_year(YYYY), YYYY\400 = 0.
is_leap_year(YYYY) :- calc_leap_year(YYYY), YYYY\4 = 0, YYYY\100 != 0.

%
% Calculate last date of month
%

big_month(1;3;5;7;8;10;12).
small_month(4;6;9;11).

last_date_month(31,MM,YYYY) :- 
	date_consider_month(MM,YYYY), 
	big_month(MM).

last_date_month(30,MM,YYYY) :- 
	date_consider_month(MM,YYYY), 
	small_month(MM).

last_date_month(28,2,YYYY) :- 
	date_consider_month(2,YYYY), 
	not is_leap_year(YYYY).

last_date_month(29,2,YYYY) :- 
	date_consider_month(2,YYYY), 
	is_leap_year(YYYY).

%
% Generate date_consider/1 for a given month/year
%

date_consider((1..DD,MM,YYYY)) :-
	date_consider_month(MM,YYYY),	
	last_date_month(DD,MM,YYYY).

%
% Generate date_consider/1 for a given year
%

date_consider_month(1..12,YYYY) :- date_consider_year(YYYY).


