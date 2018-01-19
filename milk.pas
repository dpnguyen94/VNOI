{
ID: ndchiph1
PROG: milk
LANG: PASCAL
}

program milk;
uses crt;
const   MAX_M = 5000;
var     fi,fo: text;
        p,a: array[1..MAX_M] of longint;
        n,m: longint;

procedure input;
var     i: longint;
begin
        readln(fi,n,m);
        for i:= 1 to m do readln(fi,p[i],a[i]);
end;

procedure swap(var x,y: longint);
var     z: longint;
begin
        z:= x; x:= y; y:= z;
end;

procedure sort(le,ri: longint);
var     i,j,t: longint;
begin
        if (le >= ri) then exit;
        i:= le; j:= ri;
        t:= p[(i+j) div 2];
        //
        repeat
                while (p[i] < t) do inc(i);
                while (p[j] > t) do dec(j);
                //
                if (i <= j) then begin
                        if (i < j) then begin
                                if (p[i] > p[j]) or (a[i] < a[j]) then begin
                                        swap(p[i],p[j]);
                                        swap(a[i],a[j]);
                                end;
                        end;
                        inc(i); dec(j);
                end;

        until i >= j;
        //
        sort(le,j);
        sort(i,ri);
end;

procedure process;
var     i,j,milk: longint;
        min_cost: int64;
begin
        sort(1,m);
        //
        i:= 1;
        milk:= 0;
        while (milk < n) do begin
                inc(milk,a[i]);
                inc(i);
        end;
        dec(i);
        dec(a[i],milk-n);
        //
        min_cost:= 0;
        for j:= 1 to i do inc(min_cost,p[j]*a[j]);

        writeln(fo,min_cost);
end;


begin
        assign(fi,'milk.in'); reset(fi);
        assign(fo,'milk.out'); rewrite(fo);
        //
        input;
        process;
        //
        close(fi);
        close(fo);
end.
