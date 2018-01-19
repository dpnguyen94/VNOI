program vcoldwat;
uses crt;
const   MAX_N = 100000;
var     fi,fo: text;
        n,c: longint;
        a: array[1..MAX_N,1..2] of longint;
        d: array[1..MAX_N] of longint;

procedure input;
var     i,j,x,y: longint;
begin
        fillchar(a,sizeof(a),0);
        //
        readln(fi,n,c);
        for i:= 1 to c do readln(fi,j,a[j,1],a[j,2]);
end;

procedure count(i: longint);
begin
        if (a[i,1] <> 0) then begin
                d[a[i,1]]:= d[i]+1;
                d[a[i,2]]:= d[i]+1;
                count(a[i,1]);
                count(a[i,2]);
        end;
end;

procedure output;
var     i: longint;
begin
        for i:= 1 to n do writeln(fo,d[i]);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        input;
        d[1]:= 1;
        count(1);
        output;
        //
        close(fi);
        close(fo);
end.