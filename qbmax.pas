program qbmax;
uses crt;
const   fi = '';
        fo = '';
var     f: text;
        a: array[1..100,1..100] of integer;
        s: array[0..101,0..101] of integer;
        m,n: 1..100;

procedure nhap;
var     i,j: integer;
begin
        assign(f,fi); reset(f);
        readln(f,m,n);
        for i:= 1 to m do begin
                for j:= 1 to n do read(f,a[i,j]);
                readln(f);
        end;
        close(f);
end;

function max_2(a,b: integer): integer;
begin
        if a>b then max_2:= a
        else max_2:= b;
end;

function max_3(a,b,c: integer): integer;
var     t: integer;
begin
        if a>b then t:= a else t:= b;
        if c>t then t:= c;
        //
        max_3:= t;
end;

procedure xuli;
var     i,j,max,sum: integer;
begin
        assign(f,fo); rewrite(f);
        //init;
        for i:= 0 to 101 do begin
                s[0,i]:= -10000;
                s[101,i]:= -10000;
                s[i,0]:= -10000;
                s[i,101]:= -10000;
        end;
        for i:= 1 to m do s[i,1]:= a[i,1];
        //
        for j:= 2 to n do begin
                s[1,j]:= max_2(s[1,j-1],s[2,j-1])+a[1,j];
                //
                for i:= 2 to m-1 do s[i,j]:= max_3(s[i-1,j-1],s[i,j-1],s[i+1,j-1])+a[i,j];
                //
                s[m,j]:= max_2(s[m,j-1],s[m-1,j-1])+a[m,j];
        end;
        //find_max;
        max:= -10000;
        for i:= 1 to m do if s[i,n] > max then max:= s[i,n];
        //
        writeln(f,max);
        close(f);
end;

begin
        nhap;
        xuli;
end.
