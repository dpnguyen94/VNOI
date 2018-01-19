uses math;
const
	maxN = 100010;
var
	fi,fo: text;
	a: array[1..maxN] of longint;
    n: longint;
    res: int64;

procedure input;
var
	i: longint;
begin
	readln(fi,n);
    for i:= 1 to n do
    begin
    	read(fi,a[i]);
        inc(res,a[i]);
    end;	
end;

procedure sort(le,ri: longint);
var
	i,j,t,z: longint;
begin
	if (le >= ri) then exit;
    i:= le; j:= ri;
    t:= a[(i + j) div 2];

    repeat
    	while (a[i] < t) do inc(i);
        while (a[j] > t) do dec(j);

        if (i <= j) then
        begin
			z:= a[i]; a[i]:= a[j]; a[j]:= z;
            inc(i); dec(j);
        end;
    until i >= j;

    sort(le,j);
    sort(i,ri);
end;

procedure process;
var
	i: longint;
begin
	sort(1,n);
    //
    for i:= 1 to n div 2 do inc(res,a[n-i+1] - a[i]);
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
