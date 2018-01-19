program nth_digit_hexa;
uses crt;
const   fi = 'hex.inp';
        fo = 'hex.out';
var     n: longint;
        l,c: array[0..10] of longint;
        d: array[1..10] of byte;
        j: byte;
        f: text;

procedure init;
var     i,m: byte;
begin
        c[0] := 0; l[0]:= 0;
        c[1] := 15; l[1]:= 15;
        m := 2;
        for i:= 2 to 7 do
        begin
                c[i] := (c[i-1] div (i-1))*16*m;
                inc(m);
                l[i] := l[i-1]*16 + 15; {mang l[] luu cac so dau tien cua day co 1,2,3,... chu so}
        end;
end;

procedure print(i: byte);
begin
        assign(f,fo); rewrite(f);
        case i of
        10: writeln(f,'A');
        11: writeln(f,'B');
        12: writeln(f,'C');
        13: writeln(f,'D');
        14: writeln(f,'E');
        15: writeln(f,'F');
        else writeln(f,i);
        end;
        close(f);
end;

procedure tim;
var     i,j: byte;
        k: longint;
begin
        i:= 1;
        while (n > c[i]) do begin n := n-c[i]; inc(i); end;
        if (n mod i <> 0) then
        begin
                k:= l[i-1] + (n div i) + 1;
                n:= n mod i;
                j:= 1;
                while k > 0 do {luu cac chu so hexa cua k vao mang d}
                begin
                        d[j] := k mod 16; k:= k div 16;
                        inc(j);
                end;

                print(d[j-n]);
        end
        else
        begin
                k:= l[i-1] + (n div i);
                print(k mod 16);
        end;
end;

begin
        assign(f,fi); reset(f);
        readln(f,n);
        close(f);
        init;
        tim;
end.
