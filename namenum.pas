{
ID: ndchiph1
PROG: namenum
LANG: PASCAL
}
program namenum;
uses crt;
var     fi,fo: text;
        d: array[1..5000] of string[20];
        a: array[1..12] of 2..9;
        n,len: integer;
        c: array[2..9] of set of char;


procedure input;
begin
        n:= 0;
        assign(fi,'dict.txt'); reset(fi);
        while not eof(fi) do begin
                inc(n);
                readln(fi,d[n]);
        end;
        close(fi);
end;

procedure init;
begin
        c[2]:= ['A','B','C'];
        c[3]:= ['D','E','F'];
        c[4]:= ['G','H','I'];
        c[5]:= ['J','K','L'];
        c[6]:= ['M','N','O'];
        c[7]:= ['P','R','S'];
        c[8]:= ['T','U','V'];
        c[9]:= ['W','X','Y'];
end;

procedure sort(l,r: integer);
var     i,j: integer;
        z,t: string[20];
begin
        if (l >= r) then exit;
        i:= l; j:= r;
        t:= d[(i+j) div 2];
        //
        repeat
                while (d[i] < t) do inc(i);
                while (d[j] > t) do dec(j);
                //
                if (i <= j) then begin
                        if (i < j) then begin
                                z:= d[i]; d[i]:= d[j]; d[j]:= z;
                        end;
                        inc(i); dec(j);
                end;
        until i>=j;
        //
        sort(l,j);
        sort(i,r);
end;

function valid(i: integer): boolean;
var     j: integer;
begin
        if (length(d[i]) > len) then exit(false);
        //
        for j:= 1 to len do
         if not (d[i][j] in (c[a[j]])) then exit(false);
        //
        exit(true);
end;


procedure process;
var     i,j: integer;
        s: string[12];
        exist: boolean;
begin
        sort(1,n);
        init;
        //
        assign(fi,'namenum.in'); reset(fi);
        assign(fo,'namenum.out'); rewrite(fo);
        readln(fi,s);
        len:= length(s);
        for i:= 1 to len do val(s[i],a[i],j);
        //
        exist:= false;
        for i:= 1 to n do
         if valid(i) then begin
                writeln(fo,d[i]);
                exist:= true;
         end;
        if not exist then writeln(fo,'NONE');

        close(fi);
        close(fo);
end;

begin
        input;
        process;
end.
