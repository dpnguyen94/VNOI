uses math;
var     fi,fo: text;
        n,min_a,t1,t2: integer;
        a: array[1..100,1..100] of integer;
        vs: array[0..101,0..101] of boolean;
        exist: boolean;
        dx: array[1..4] of integer = (-1,1,0,0);
        dy: array[1..4] of integer = (0,0,1,-1);

procedure input;
var     i,j: integer;
begin
        readln(fi,n);
        for i:= 1 to n do begin
                for j:= 1 to n do read(fi,a[i,j]);
                readln(fi);
        end;
        if (a[1,1] < a[n,n]) then min_a:= a[1,1]
        else min_a:= a[n,n];
end;


procedure loang(x,y: integer);
var     k: integer;
begin
        if (x < 1) or (y < 1) or (x > n) or (y > n) then exit;
        if (a[x,y] < t1) or (a[x,y] > t2) or (vs[x,y]) or exist then exit;
        //
        vs[x,y]:= true;
        if vs[n,n] = true then begin exist:= true; exit; end;
        for k:= 1 to 4 do loang(x+dx[k],y+dy[k]);
end;

function lienthong(l,m: integer): boolean;
begin
        fillchar(vs,sizeof(vs),false);
        t1:= l; t2:= m;
        exist:= false;
        loang(1,1);
        exit(exist);
end;

procedure process;
var     min_d,low,high,mid,fi,la: integer;
begin
        min_d:= 10000;
        for low:= 0 to min_a do begin
                fi:= low; la:= 110;
                while (fi <= la) do begin
                        mid:= (fi+la) div 2;
                        if lienthong(low,mid) then begin
                                high:= mid;
                                if (high - low < min_d) then min_d:= high - low;
                                la:= mid-1;
                        end
                        else fi:= mid+1;
                end;
        end;
        //
        writeln(fo,min_d);
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
