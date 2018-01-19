program haf1;
uses crt;
const   MAX_R = 1000001;
var     fi,fo: text;
        a: array[0..1001,0..1001] of integer;
        f: array[0..1001,0..1001] of longint;
        n,m: integer;

procedure input;
var     i,j: integer;
begin
        fillchar(a,sizeof(a),0);
        readln(fi,n,m);
        for i:= 1 to m do begin
                for j:= 1 to n do read(fi,a[i,j]);
                readln(fi);
        end;
end;

function min(x,y: longint): longint;
begin
        if (x < y) then exit(x)
        else exit(y);
end;

procedure process;
var     i,j: integer;
        res: longint;
begin
        for i:= 0 to m+1 do begin
                f[i,0]:= MAX_R;
                f[i,n+1]:= MAX_R;
        end;
        //
        for i:= 1 to m do begin
                for j:= 1 to n do f[i,j]:= min(f[i-1,j],f[i,j-1])+a[i,j];
                for j:= n downto 1 do f[i,j]:= min(f[i,j],f[i,j+1]+a[i,j]);
        end;
        //
        res:= maxlongint;
        for i:= 1 to n do if (f[m,i] < res) then res:= f[m,i];
        //
        writeln(fo,res);
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