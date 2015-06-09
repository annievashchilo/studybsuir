program lab1;

uses
    Crt, Math;
type
  TSeries = record
    summa : Real;
    niters : Integer;
  end;


function f1(x : Real): Real;
var
  y: Real;
begin
     y := 1.0 / (1.0 - x);
     Result := y * ln(y);
end;


function f2(x : Real; e : Real) : TSeries;
function term(k : Integer) : Real;
var
  n : Integer;
begin
     Result := 0;
     for n := 1 to k do
     begin
       Result := Result + Power(x, k) * (1.0 / n);
     end;
end;
var
  t : Real;
  k : Integer = 1;
begin
     Result.summa := 0;
     Result.niters := 0;

     while true do
     begin
       t := term(k);
       if abs(t) < e then break;
       Result.summa := Result.summa + t;
       Result.niters := k;
       inc(k);
     end;
end;

{------------------------------------------------------------------------------}
var
  v1: Real;
  v22, v23, v24 : TSeries;
  x : Real;
  n : Integer;
const
  step = 0.05;
  x0 = -0.6;
begin
     ClrScr;
     writeln('+-------+-------------+-----------+-----------+------------+');
     writeln('|       |             |   e=0.01  |  e=0.001  | e= 0.0001  |');
     writeln('|   x   |    f1(x)    +-------+---+-------+---+--------+---+');
     writeln('|       |             | f2(x) | N | f2(x) | N |  f2(x) | N |');
     writeln('+-------+-------------+-------+---+-------+---+--------+---+');

     for n := 1 to 20 do
     begin
       x := x0 + step * (n - 1);

       v1 := f1(x);
       v22 := f2(x, 1e-2);
       v23 := f2(x, 1e-3);
       v24 := f2(x, 1e-4);

       writeln(
          '| ', x:6:2,
          '| ', v1:12:5,
          '| ', v22.summa:6:2,
          '| ',	v22.niters:2,
          '| ', v23.summa:6:3,
          '| ', v23.niters:2,
          '| ', v24.summa:7:4,
          '| ', v24.niters:2,
          '|');
     end;

     write('+-------+-------------+-------+---+-------+---+--------+---+');

     ReadLn;
end.
