program nktick;
uses crt;
const   C = 60000;
var     s: array[1..C] of longint;
        t,r: array[1..C] of longint;
        n: word;

procedure nhap;
var     i: word;
begin
        readln(n);
        for i:= 1 to n do read(t[i]);
        readln;
        for i:= 1 to n-1 do read(r[i]);
end;

function min(a,b: longint): longint;
begin
        if a>b then min:= b
        else min:= a;
end;

procedure xuli;
var     i: word;
begin
        //init;
        s[n]:= t[n];
        //
        for i:= n-1 downto 1 do s[i]:= min(s[i+1]+t[i],s[i+2]+r[i]);
        writeln(s[1]);
end;

begin
        nhap;
        xuli;
        readln;
end.
