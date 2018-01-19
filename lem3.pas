program lem3;
uses crt;
const   fi = '';
        fo = '';
var     c: array[0..16,0..16] of integer;
        free: array[0..16] of boolean;
        b: array[0..16] of longint;
        min: longint;
        n,t: integer;
        f: text;

procedure nhap;
var     i,j: integer;
begin
        assign(f,fi); reset(f);
        readln(f,n);
        for i:= 1 to n do begin
                for j:= 1 to n do read(f,c[i,j]);
                readln(f);
        end;
        close(f);
end;

procedure calc;
var     i: integer;
        s: longint;
begin
        s:= 0;
        for i:= 1 to n-1 do inc(s,c[b[i],b[i+1]]);
        //
        if (s < min) then min:= s;
end;

procedure attempt(i: integer; sum: longint);
var     j: integer;
begin
        if (i > n) then begin
                calc;
                exit;
        end;
        //
        for j:= 1 to n do
         if free[j] then
          if (sum + c[b[i-1],j] < min) then begin
                b[i]:= j; free[j]:= false;
                attempt(i+1,sum+c[b[i-1],j]);
                free[j]:= true;
          end;
end;

begin
        nhap;
        //init;
        fillchar(free,sizeof(free),true);
        for t:= 1 to n do c[0,t]:= 0;
        b[0]:= 0;
        min:= maxlongint;
        //
        attempt(1,0);
        assign(f,fo); rewrite(f);
        writeln(f,min);
        close(f);
end.
