program baseh;
uses crt;
var     k,h,i,j: longint;
        a: array[1..32] of 0..1;

begin
        readln(k,h);
        i:= 1;
        while (k > 0) do begin
                a[i]:= k mod 2; inc(i);
                k:= k div 2;
        end;
        for j:= i-1 downto 1 do write(a[j]);
end.