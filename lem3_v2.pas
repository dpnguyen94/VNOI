program lem3;
uses crt;
const   MAX_N = 16;
        MAX_C = 100000;
var     fi,fo: text;
        c: array[0..MAX_N,0..MAX_N] of longint;
        f: array[0..100000,0..MAX_N] of longint;
        n: byte;

function getbit(x: longint; y: byte): byte;
begin
        exit((x shr y) and 1);
end;

function offbit(x: longint; y: byte): longint;
begin
        exit(x and (not (1 shl y)));
end;

procedure input;
var     i,j: integer;
begin
        readln(fi,n);
        for i:= 0 to n-1 do begin
                for j:= 0 to n-1 do read(fi,c[i,j]);
                readln(fi);
        end;
end;

procedure process;
var     i,t,tt,min: longint;
        j,k: byte;
begin
        for i:= 0 to n-1 do f[0,i]:= 0;
        t:= (1 shl n) - 1;
        for i:= 1 to t do begin
                for j:= 0 to 15 do
                 if getbit(i,j) = 0 then f[i,j]:= maxlongint
                 else begin
                        min:= maxlongint;
                        for k:= 0 to 15 do
                         if (getbit(i,k) = 1) and (k <> j) then begin
                                tt:= f[offbit(i,j),k] + c[k,j];
                                if tt < min then min:= tt;
                         end;
                         if min = maxlongint then f[i,j]:= 0
                         else f[i,j]:= min;
                 end;
        end;
        //
        min:= maxlongint;
        for i:= 0 to n-1 do
         if (f[t,i] < min) then min:= f[t,i];
        writeln(fo,min);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        input;
        process;
        //
        close(fi);
        close(fo);
end.
