program mulone;
uses crt;
var     n,k: longint;
        a,b: array[1..1000000] of longint;
        f: text;
        j: longint;
        fo: text;

procedure xuli;
var     i,t,mem: longint;
begin
        mem:= 0;
        for i:= 1 to n do begin
                t:= i + mem;
                a[i]:= t mod 10;
                mem:= t div 10;
        end;
        //
        for i:= n-1 downto 2 do begin
                t:= i + mem;
                b[i]:= t mod 10;
                mem:= t div 10;
        end;
        //
        b[1]:= 1 + mem;
        //
        for i:= 1 to n-1 do write(fo,b[i]);
        for i:= n downto 1 do write(fo,a[i]);
        writeln(fo);
end;


begin
        assign(fo,''); rewrite(fo);
        readln(k);
        for j:= 1 to k do begin
                readln(n);
                xuli;
        end;
        close(fo);
end.
