program auction;
uses crt;
const   C = 1000;
var     a: array[1..C] of longint;
        n,m: 1..C;

procedure enter;
var     i: integer;
begin
        readln(n,m);
        for i:= 1 to m do readln(a[i]);
end;

procedure swap(var x,y:longint);
var     z: longint;
begin
        z:= x; x:= y; y:= z;
end;

procedure sort(L,R: integer);
var     i,j: integer;
        z,t: longint;
begin
        if L>=R then exit;
        i:= L; j:=R;
        t:= a[random(R - L + 1) + L];
        repeat
                while (a[i] < t) do inc(i);
                while (a[j] > t) do dec(j);

                if i <= j then
                begin
                        if i < j then swap(a[i],a[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        //
        sort(L,j);
        sort(i,R);
end;

procedure calculate;
var     max,tt,z: longint;
        i,j: 1..C;
begin
        max:= 0; z := maxlongint;
        //if (n>=m) then j:= 1 else j:= m-n+1;
        for i:= 1 to m do begin
                if m-i+1 > n then continue;
                tt:= a[i]*(m-i+1);
                if (tt > max) then begin
                        max:= tt;
                        z:= a[i];
                end;
        end;
        //
        writeln(z,' ',max);
end;

begin
        enter;
        sort(1,m);
        calculate;
end.
