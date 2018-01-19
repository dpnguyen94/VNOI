program nkdivseq;
uses crt;
var     a: array[1..1000] of longint;//luu so dau tien cua day i so chia het cho i
        n: longint;

procedure init;
var     i: integer;
        last_num: longint;
begin
        a[1]:= 1;
        //
        for i:= 2 to 1000 do begin
                last_num:= a[i-1]+(i-1)*(i-2);
                a[i]:= last_num + (i- last_num mod i);
        end;
end;

procedure calculate;
var    sum,i: longint;
begin
        sum:= 0; i:= 0;
        //
        while (sum < n) do begin
            inc(i);
            sum:= sum+i;
        end;
        //
        if (sum = n) then writeln(a[i]+i*(i-1))
        else begin
                n:= n-(sum-i);
                writeln(a[i]+i*(n-1));
        end;
end;

begin
        readln(n);
        init;
        calculate;
end.
