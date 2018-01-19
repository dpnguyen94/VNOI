program fwater;
uses crt;
var     fi,fo: text;
        p: array[0..300,0..300] of longint;
        d: array[0..300] of longint;
        pre: array[0..300] of integer;
        vs: array[0..300] of boolean;
        n: integer;

procedure input;
var     w: longint;
        i,j: integer;
begin
        readln(fi,n);
        p[0,0]:= 0;
        for i:= 1 to n do begin
                readln(fi,w);
                p[0,i]:= w;
                p[i,0]:= w;
        end;
        for i:= 1 to n do begin
                for j:= 1 to n do begin
                        read(fi,p[i,j]);
                        if (i <> j) and (p[i,j] = 0) then p[i,j]:= maxlongint;
                end;
                readln(fi);
        end;
end;

procedure prim;
var     k,i,j: integer;
        min_d: longint;
begin
        //init;
        d[0]:= 0;
        for i:= 1 to n do d[i]:= maxlongint;
        fillchar(vs,sizeof(vs),false);

        //process;
        for k:= 0 to n do begin
                j:= 0; min_d:= maxlongint;
                for i:= 0 to n do
                 if (not vs[i]) and (d[i] < min_d) then begin
                        min_d:= d[i];
                        j:= i;
                 end;
                vs[j]:= true;
                for i:= 0 to n do
                 if (not vs[i]) and (d[i] > p[j,i]) then begin
                        d[i]:= p[j,i];
                        pre[i]:= j;
                 end;
        end;
end;

procedure output;
var     i: integer;
        w: longint;
begin
        w:= 0;
        for i:= 1 to n do inc(w,p[pre[i],i]);
        writeln(fo,w);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        input;
        prim;
        output;
        //
        close(fi);
        close(fo);
end.
