program xephau;
uses crt;
const   MN = 100;
        fi = 'xephau.inp';
        fo = 'xephau.out';
var     v: array[1..MN] of byte;
        n,i: byte;
        f : text;

function datduoc(i: byte): boolean;
var j: byte;
begin
        datduoc := true;
        for j:= 1 to i-1 do
        begin
                if (v[i] = v[j]) or (abs(v[i]-v[j]) = i- j) then datduoc := false;
        end;
end;

function tim(i: byte): boolean;
begin
        tim := true;
        while (v[i] < n) do
        begin
                inc(v[i]);
                if datduoc(i) then exit;
        end;
        tim := false;
end;

procedure ketqua(i: byte);
var     j,x,y: integer;
        a: array[1..MN,1..MN] of char;
begin
        assign(f,fo); rewrite(f);
        if i = 0 then writeln(f,0);
        if i = n then
        begin
                for x:= 1 to n do
                        for y:= 1 to n do a[x,y]:= '.';
                for j:= 1 to n do a[j,v[j]]:= 'H';

                for x:= 1 to n do
                begin
                        for y:= 1 to n do
                                write(f,a[x,y]:3);
                                writeln(f);
                end;

        end;
                {for j:= 1 to n do writeln(f,'Hau thu ',j,' o hang thu ',v[j]);}
        close(f);
end;

begin
        assign(f,fi); reset(f);
        readln(f,n);
        close(f);
        for i:= 1 to n do v[i]:= 0;
        i := 1;
        repeat
                if i > n then begin ketqua(n); exit; end;
                if i < 1 then begin ketqua(0); exit; end;
                if tim(i) then inc(i) {tien}
                else begin v[i] := 0; dec(i) end;
        until i = -1;
end.
