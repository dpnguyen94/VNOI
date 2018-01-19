Program ducdeptrai;
Uses    Crt;
Var     n,k:byte;
        a:array[1..50] of integer;
        b:array[1..1000] of boolean;
        s:integer;

Procedure nhap; {gan du lieu}
Var       i:integer;
Begin
n:=8;
a[1]:=1;
a[2]:=3;
a[3]:=6;
a[4]:=65;
a[5]:=28;
a[6]:=67;
a[7]:=76;
a[8]:=43;
k:=10;
s:=0;
For i:=1 to 1000 do b[i]:=false;
End;

Procedure attempt(x:byte); {thu tuc quay lui}
Var       i:byte;
Begin
 For i:=1 to n do
  begin
   s:=s+a[i];
   If x<k then attempt(x+1);
   b[s]:=true;
   s:=s-a[i];
  end;
End;

Begin
clrscr;
nhap;
attempt(1);
s:=1;
while b[s] do inc(s);
writeln(s-1);
readln;
End.