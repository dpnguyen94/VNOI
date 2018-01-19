program phanso;
uses crt;
const   fi = 'phanso.in';
        fo = 'phanso.out';
var     a,b: array[1..20] of longint;
        c: array[1..2,1..400] of longint;
        m,n,kk: integer;
        tt,k: integer;
        f: text;

function gcd(a,b: longint): longint;
begin
        if (a = 1) and (b = 1) then begin gcd:= 1; exit; end;
        if (a = 0) or (b = 0) then begin gcd:= a+b; exit; end;
        if a > b then gcd:= gcd(b,a mod b)
        else gcd:= gcd(a,b mod a);
end;

procedure swap(var a,b:longint);
var     z: longint;
begin
        z:= a; a:= b; b:= z;
end;

procedure init;
var     i,j: integer;
begin
        k:= 1;
        for i:= 1 to m do
                for j:= 1 to n do
                begin
                        c[1,k]:= a[i] div gcd(a[i],b[j]);
                        c[2,k]:= b[j] div gcd(a[i],b[j]);
                        inc(k);
                end;
        dec(k);
end;

procedure sort;
var     sw: boolean;
        i: integer;
begin
        sw:= false;
        while (sw = false) do
        begin
                sw:= true;
                for i:= 1 to k-1 do
                        if (c[1,i]/c[2,i] > c[1,i+1]/c[2,i+1]) then
                        begin
                                swap(c[1,i],c[1,i+1]);
                                swap(c[2,i],c[2,i+1]);
                                sw:= false;
                        end;
        end;
end;

procedure tim_k;
var     t,i,j: integer;
begin

        for i:= 1 to k-1 do
        begin
                for j:= i+1 to k do
                        if (c[1,j]/c[2,j] = c[1,i]/c[2,i]) and (c[1,j] <> 0) then c[1,j]:= 0;
        end;

        t:= 1;
        while(kk > 0) do
        begin
              if c[1,t] <> 0 then begin dec(kk); a[1]:= c[1,t]; b[1]:= c[2,t]; end;
              inc(t);
        end;
        assign(f,fo); rewrite(f);
        writeln(f,a[1],' ',b[1]);

        close(f);
end;

begin
        assign(f,fi); reset(f);
        read(f,m,n,kk);
        for tt:= 1 to m do read(f,a[tt]);
        for tt:= 1 to n do read(f,b[tt]);
        close(f);

        init; sort; tim_k;

end.
