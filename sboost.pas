program sboost;
uses crt;
const   MAX_N = 10000;
var     fi,fo: text;
        f,m,n: longint;
        a,b,id: array[1..MAX_N] of longint;
        c: array[1..MAX_N] of real;

procedure init;
var     i: integer;
begin
        readln(fi,f,m,n);
        for i:= 1 to n do begin
                readln(fi,a[i],b[i]);
                c[i]:= a[i]/b[i];
                id[i]:= i;
        end;
end;

procedure swap(var x,y: longint);
var     z: longint;
begin
        z:= x; x:= y; y:= z;
end;

procedure sort_c(l,r: longint);
var     i,j: longint;
        z,t: real;
begin
        if l>=r then exit;
        i:= l; j:=r;
        t:= c[(l+r) div 2];
        repeat
                while (c[i] > t) do inc(i);
                while (c[j] < t) do dec(j);

                if i <= j then
		begin
			if i < j then
                         if (c[i] < c[j]) or (id[i] < id[j]) then begin
                                swap(a[i],a[j]);
                                swap(b[i],b[j]);
                                z:= c[i]; c[i]:= c[j]; c[j]:= z;
                                swap(id[i],id[j]);
                         end;
                	inc(i); dec(j);
                end;
        until i >= j;

        sort_c(l,j);
        sort_c(i,r);
end;

procedure sort_id(l,r: longint);
var     i,j,t: longint;
begin
        if l>=r then exit;
        i:= l; j:=r;
        t:= id[(l+r) div 2];
        repeat
                while (id[i] < t) do inc(i);
                while (id[j] > t) do dec(j);

                if i <= j then
		begin
			if i < j then swap(id[i],id[j]);
                	inc(i); dec(j);
                end;
        until i >= j;

        sort_id(l,j);
        sort_id(i,r);
end;

procedure process;
var     i,tr: integer;
begin
        sort_c(1,n);
        //
        for i:= 1 to n do
         if (a[i]/b[i] > f/m) then begin
                f:= f+a[i];
                m:= m+b[i];
         end
         else begin tr:= i-1; break; end;
        //
        sort_id(1,tr);
        if (tr = 0) then writeln('NONE')
        else for i:= 1 to tr do writeln(fo,id[i]);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        init;
        process;
        //
        close(fi);
        close(fo);
end.