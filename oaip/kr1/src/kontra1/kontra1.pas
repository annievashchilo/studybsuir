program kontra1;


uses
    sysutils, strutils;

type
     Factor = record
          prime : Integer;       {простой множитель}
          count : Integer;       {количество простых множителей}
     end;
     Factorization = array of Factor;


function FindFactor(prime: Integer; var fx: Factorization): Integer;
var
   i: Integer;
   e: Factor;
begin
     Result := -1;
     for i := Low(fx) to High(fx) do begin
             e := fx[i];
             if (e.prime = prime) then begin
                     Result := i;
                     break;
             end;
     end;
end;

procedure AddFactor(prime: Integer; var fx: Factorization);
var
   p: Integer;
begin
     p := FindFactor(prime, fx);
     if (p <> -1) then begin
             inc(fx[p].count);
     end
     else begin
             SetLength(fx, Length(fx)+1);
             fx[High(fx)].prime := prime;
             fx[High(fx)].count := 1;
     end;
end;

function GeneratePrimes(n : Integer) : IntArray;
var
   sieve: array of boolean;
   i,j : Integer;
begin
     SetLength(result, 0);
     if (n > 0) then begin
             SetLength(sieve, n+1);
             for i := 0 to high(sieve) do begin
                     sieve[i] := True;
             end;

             for i := 2 to high(sieve) do begin
                     if (sieve[i]) then begin
                             j := i*2;
                             while (j <= High(sieve)) do begin
                                   sieve[j] := False;
                                   inc(j, i);
                             end;
                     end;
             end;

             for i := 1 to high(sieve) do begin
                   if (sieve[i]) then begin
                           SetLength(result, length(result)+1);
                           result[high(result)] := i;
                   end;
             end;
     end;
end;

function Factorize(n : Integer) : Factorization;
var
   p, d, r : Integer;
   i : Integer = 0;
   primes : array of Integer;
begin
     SetLength(result, 0);
     primes := GeneratePrimes(n);       // вычисляются все простые числа до n
     repeat
         p := primes[i];
         d := n div p;
         r := n mod p;
         if (r = 0) then begin
                 if (p = 1) then begin
                         if (FindFactor(p, result) = -1 ) then AddFactor(p, Result);
                         inc(i);
                 end
                 else begin
                     AddFactor(p, Result);
                     i := 0;
                 end;

                 n := d;
         end
         else begin
                inc(i);
         end;
     until (n <= 1);
end;

var
   m, i, j : Integer;
   s : String;
   fx: Factorization;
   f: factor;
begin
  write('Enter m: ');
  readln(s);
  m := StrToIntDef(s, 0);
  if (m < 1) then begin
          WriteLn('Error: m = ', m);
          ReadLn;
          Exit;
  end;

  fx := Factorize(m);
  for i := Low(fx) to High(fx) do begin
      f := fx[i];
      for j := 1 to f.count do begin
          Write(f.prime, ' ');
      end;
  end;
  WriteLn('');
  ReadLn;

end.

