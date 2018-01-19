program lis;
const   MAX_N = 30000;
var     a,l,startof: array[0..MAX_N+1] of longint;
        n,m: integer;
        fi,fo: text;

procedure input;
var     i: integer;
begin
        readln(fi,n);
        for i:= 1 to n do read(fi,a[i]);
end;

function find(i: integer): integer;
var     inf,sup,median,j: integer;
begin
        inf:= 1; sup:= m+1;
        repeat
                median:= (inf+sup) div 2;
                j:= startof[median];
                if (a[j] > a[i]) then inf:= median
                else sup:= median;
        until inf+1 = sup;
        exit(startof[inf]);
end;


procedure process;
var     i,j,k: integer;
begin
        //init;
        a[0]:= -maxlongint;
        a[n+1]:= maxlongint;
        m:= 1;
        l[n+1]:= 1;
        startof[1]:= n+1;
        //
        for i:= n downto 0 do begin
                j:= find(i);
                k:= l[j]+1;
                if (k > m) then begin
                        m:= k;
                        startof[k]:= i;
                end
                else if (a[startof[k]] < a[i]) then startof[k]:= i;
                l[i]:= k;
        end;

        writeln(fo,m-2);
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