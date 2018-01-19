{
ID: ndchiph1
PROG: transform
LANG: PASCAL
}
program transform;
uses crt;
type    mang = array[1..10,1..10] of char;
var     fi,fo: text;
        a,b,c,f: mang;
        n,i,j: integer;


procedure input;
begin
        readln(fi,n);
        for i:= 1 to n do begin
                for j:= 1 to n do read(fi,a[i,j]);
                readln(fi);
        end;
        for i:= 1 to n do begin
                for j:= 1 to n do read(fi,f[i,j]);
                readln(fi);
        end;
end;

function valid: boolean;
begin
        for i:= 1 to n do
         for j:= 1 to n do
          if (b[i,j] <> f[i,j]) then exit(false);
        //
        exit(true);
end;


procedure assgn(var x,y: mang);
begin
        for i:= 1 to n do
         for j:= 1 to n do x[i,j]:= y[i,j];
end;

procedure do1;
begin
        for i:= 1 to n do
         for j:= 1 to n do b[i,j]:= c[n-j+1,i];
end;

procedure do2;
begin
        for i:= 1 to n do
         for j:= 1 to n do b[i,j]:= c[n-i+1,n-j+1];
end;

procedure do3;
begin
        do1;
        assgn(c,b);
        do2;
end;

procedure do4;
begin
        for i:= 1 to n do
         for j:= 1 to n do b[i,j]:= c[i,n-j+1];
end;

procedure do5_1;
begin
        do4;
        assgn(c,b);
        do1;
end;

procedure do5_2;
begin
        do4;
        assgn(c,b);
        do2;
end;

procedure do5_3;
begin
        do4;
        assgn(c,b);
        do3;
end;

function process: integer;
begin
        assgn(c,a); do1;
        if valid then exit(1);

        assgn(c,a); do2;
        if valid then exit(2);


        assgn(c,a); do3;
        if valid then exit(3);


        assgn(c,a); do4;
        if valid then exit(4);


        assgn(c,a); do5_1;
        if valid then exit(5);


        assgn(c,a); do5_2;
        if valid then exit(5);

        assgn(c,a); do5_3;
        if valid then exit(5);

        assgn(b,a);
        if valid then exit(6);

        exit(7);
end;

begin
        assign(fi,'transform.in'); reset(fi);
        assign(fo,'transform.out'); rewrite(fo);
        //
        input;
        writeln(fo,process);
        //
        close(fi);
        close(fo);
end.
