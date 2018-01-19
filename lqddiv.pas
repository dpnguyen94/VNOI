uses math;
const
	maxN = 35;
    maxF = 67000;
//type

var                                	
	fi,fo: text;
    n,n1,cnt,cnt1,cnt2,first: longint;
    res,rcnt: int64;
    a,b: array[0..maxN] of longint;
    ft,q,f1,f2: array[0..maxF] of int64;

procedure input;
var
	i: longint;
begin
	readln(fi,n);
	for i:= 1 to n do
    	read(fi,a[i]);
end;


procedure solve1;
var
	i: longint;
    sum: int64;
begin
	sum:= 0;
	for i:= 1 to n1 do
		if (b[i] = 1) then inc(sum,a[i])
        else dec(sum,a[i]);

    inc(cnt1);
    f1[cnt1]:= sum;
end;

procedure attempt1(i: longint);
var
	j: longint;
begin
	if (i > n1) then
    begin
    	solve1;
        exit;
    end;

    //
    for j:= 0 to 1 do
    begin
    	b[i]:= j;
    	attempt1(i+1);
    end;
end;

procedure solve2;
var
	i: longint;
    sum: int64;
begin
	sum:= 0;
	for i:= n1 to n do
    	if (b[i] = 1) then inc(sum,a[i])
        else dec(sum,a[i]);

    inc(cnt);
    ft[cnt]:= sum;
end;

procedure attempt2(i: longint);
var
	j: longint;
begin
	if (i > n) then
    begin
    	solve2;
        exit;
    end;

    //
    for j:= 0 to 1 do
    begin
    	b[i]:= j;
    	attempt2(i+1);
    end;
end;

procedure sort(le,ri: longint);
var
	i,j: longint;
    z,t: int64;
begin
	if (le >= ri) then exit;
    i:= le; j:= ri;
    t:= ft[(i + j) div 2];

	repeat
    	while (ft[i] < t) do inc(i);
        while (ft[j] > t) do dec(j);

        if (i <= j) then
        begin
        	z:= ft[i]; ft[i]:= ft[j]; ft[j]:= z;
            inc(i); dec(j);
        end;

    until i >= j;

    sort(le,j);
    sort(i,ri);
end;

procedure solve;
begin
	n1:= n div 2;
    cnt1:= 0;
    attempt1(1);

    inc(n1);
    cnt2:= 0;
    attempt2(n1);
    sort(1,cnt);
end;

procedure search1(i: longint);
var
	le,ri,mid,rmax,cnt: longint;
	t,tt: int64;
begin
	t:= abs(f1[i]);	
    rmax:= -maxlongint;

    le:= 1; ri:= cnt2;
    while (le <= ri) do
    begin
    	mid:= (le + ri) div 2;
        if (f2[mid] < 0) then
        begin
        	le:= mid + 1;
			continue;
        end;

        if (f2[mid] <= t) then
        begin
			if (mid > rmax) then rmax:= mid;
            le:= mid + 1;
        end else ri:= mid - 1;
    end;

    if (rmax = -maxlongint) then rmax:= first;
    tt:= abs(t - f2[rmax]);
    if (rmax + 1 <= cnt2) and (abs(t - f2[rmax+1]) < tt) then tt:= abs(t - f2[rmax+1]);

    cnt:= 0;
    if (abs(t - f2[rmax]) = tt) then inc(cnt,q[rmax]);
    inc(rmax);
    if (rmax <= cnt2) and (abs(t - f2[rmax]) = tt) then inc(cnt,q[rmax]);

    if (tt < res) then
    begin
    	res:= tt;
        rcnt:= cnt;
        exit;
    end;

    if (tt = res) then inc(rcnt,cnt);
end;

procedure search2(i: longint);
var
	le,ri,mid,rmax,cnt: longint;
	t,tt: int64;
begin
	t:= f1[i];	
    rmax:= maxlongint;

    le:= 1; ri:= cnt2;
    while (le <= ri) do
    begin
    	mid:= (le + ri) div 2;
        if (f2[mid] > 0) then
        begin
        	ri:= mid - 1;
			continue;
        end;

        if (abs(f2[mid]) <= t) then
        begin
			if (mid < rmax) then rmax:= mid;
            ri:= mid - 1;
        end else le:= mid + 1;
    end;

    if (rmax = maxlongint) then rmax:= first - 1;

    cnt:= 0;
    tt:= abs(t + f2[rmax]);
    if (rmax - 1 > 0) and (abs(t + f2[rmax-1]) < tt) then tt:= abs(t + f2[rmax-1]);

    if (abs(t + f2[rmax]) = tt) then inc(cnt,q[rmax]);
    dec(rmax);
    if (rmax > 0) and (abs(t + f2[rmax]) = tt) then inc(cnt,q[rmax]);


    if (tt < res) then
    begin
    	res:= tt;
        rcnt:= cnt;
        exit;
    end;

    if (tt = res) then inc(rcnt,cnt);
end;

procedure init;
var
	i: longint;
begin
	cnt2:= 0;
	for i:= 1 to cnt do 	
		if (ft[i] <> ft[i-1]) then
        begin
        	inc(cnt2);
            f2[cnt2]:= ft[i];
            inc(q[cnt2]);
        end
        else inc(q[cnt2]);
end;                              	

procedure search3;
var
	rmax,cnt: longint;
	tt: int64;
begin
	rmax:= first;
    tt:= min(-f2[rmax-1],f2[rmax]);
	cnt:= 0;
    if (f2[rmax] = tt) then inc(cnt,q[rmax]);
    dec(rmax);
    if (-f2[rmax] = tt) then inc(cnt,q[rmax]);

    if (tt < res) then
    begin
    	res:= tt;
        rcnt:= cnt;
    end;

    if (tt = res) then inc(rcnt,cnt);
end;

procedure process;
var
	i: longint;
begin
	init;
	for i:= 1 to cnt2 do
    	if (f2[i] > 0) then
        begin
        	first:= i;
            break;
        end;

	res:= high(int64);
	
	for i:= 1 to cnt1 do
    begin
    	if (f1[i] < 0) then search1(i);
        if (f1[i] > 0) then search2(i);
        if (f1[i] = 0) then search3;
    end;

    writeln(fo,res,' ',rcnt div 2);
end;

begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
	//
    input;
    solve;
    process;
    //
    close(fi);
    close(fo);
end.
