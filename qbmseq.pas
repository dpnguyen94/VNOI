program qbmseq;
uses crt;
const   fi = '';
        fo = '';
var     n: integer;
        a,s: array[1..10000] of longint;
        f: text;

function belong(x: longint): boolean;
var     y: longint;
begin
        belong:= false;
        y:= round(sqrt(2*x));
        if (2*x <> y*(y+1)) then exit;
        belong:= true;
end;

procedure nhap;
var     i: integer;
begin
        assign(f,fi); reset(f);
        readln(f,n);
        for i:= 1 to n do readln(f,a[i]);
        close(f);
end;

procedure xuli;
var     i,max: integer;
begin
        //init;
        if belong(a[1]) then s[1]:= 1
        else s[1]:= 0;
        for i:= 2 to n do if (a[i] >= a[i-1]) and (belong(a[i])) then s[i]:= s[i-1] + 1
        else begin
                if belong(a[i]) then s[i]:= 1
                else s[i]:= 0;
        end;
        //
        max:= 0;
        for i:= 1 to n do if s[i] > max then max:= s[i];
        //
        assign(f,fo); rewrite(f);
        writeln(f,max);
        close(f);
end;

begin
        nhap;
        xuli;
end.
