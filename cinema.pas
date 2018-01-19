program cinema;
uses crt;
const   fi = '';
        fo = '';
var     a: array[1..1000,1..1000] of longint;
        m,n: 1..1000;
        k: longint;
        f: text;

procedure nhap;
var     i,j,t,x: longint;
begin
        fillchar(a,sizeof(a),0);
        //
        assign(f,fi); reset(f);
        readln(f,m,n);
        readln(f,k);
        i:= 1; j:= 1;
        for t:= 1 to k do begin
                read(f,x);
                while (x > 0) do begin
                        if (i mod 2 = 1) then begin
                                a[i,j]:= t; dec(x); inc(j);
                                if (j > n) then begin inc(i); dec(j); end;
                        end
                        else begin
                                a[i,j]:= t; dec(x); dec(j);
                                if (j < 1) then begin inc(i); inc(j); end;
                        end;
                end;

        end;
        close(f);
end;

procedure xuat;
var     i,j: integer;
begin
        assign(f,fo); rewrite(f);
        for i:= 1 to m do begin
                for j:= 1 to n-1 do write(f,a[i,j],' ');
                write(f,a[i,n]);
                writeln(f);
        end;
        close(f);
end;

begin
        nhap;
        xuat;
end.
