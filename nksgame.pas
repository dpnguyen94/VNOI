program nksgame;
uses crt;
const   MAX = 100000;
type    mang = array[1..MAX] of longint;
var     n: longint;
        b,c: mang;

procedure enter;
var     i: longint;
begin
        readln(n);
        for i:= 1 to n do read(b[i]);
        readln;
        for i:= 1 to n do read(c[i]);
end;

procedure swap(var x,y: longint);
var     z: longint;
begin
        z:= x; x:= y; y:= z;
end;

procedure sort(var a:mang; L,R: longint);
var     i,j,t: longint;
        z: longint;
begin
        if L>=R then exit;
        i:= L; j:=R;
        t:= a[(L+R) div 2];
        repeat
                while (a[i] < t) do inc(i);
                while (a[j] > t) do dec(j);

                if i <= j then
                begin
                        if i < j then swap(a[i],a[j]);
                        inc(i);dec(j);
                end;
        until i>j;

        sort(a,L,j);
        sort(a,i,R);
end;

function min(x,y: longint): longint;
begin
        if x<y then min:= x
        else min:= y;
end;

procedure process;
var     i,j,r: longint;
begin
        sort(b,1,n);
        sort(c,1,n);

        //
        i:= 1; j:= n;
        r:= maxlongint;
        while (i<=n) and (j>=1) do begin
                r:= min(r,abs(b[i]+c[j]));
                if b[i]+c[j] >= 0 then dec(j)
                else inc(i);
        end;

        //
        writeln(r);
end;

begin
        enter;
        process;
end.
