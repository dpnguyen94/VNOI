uses math;
const
	maxN = 31;
	maxV = 1510;
    LM = 33000;
//type

var                                	
	fi,fo: text;
	x,y,b: array[1..maxN] of longint;
    n,u,v,n1,cnt: longint;
    a: array[-maxV..maxV,-maxV..maxV] of longint;
    kx,ky: array[1..LM] of longint;
    res: longint;


procedure input;
var
	i: longint;
begin
	readln(fi,n);
	for i:= 1 to n do readln(fi,x[i],y[i]);
    readln(fi,u,v);
    if (u = 0) and (v = 0) then inc(res);
end;

procedure solve1;
var
 	i,j,x1,y1: longint;
begin
	x1:= 0; y1:= 0;
	for i:= 1 to n1 do
    	if (b[i] = 1) then
        begin
        	inc(j);
        	inc(x1,x[i]);
            inc(y1,y[i]);
        end;

    if (j = 0) then exit;

    inc(a[x1,y1]);
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
	i,j,x1,y1: longint;
begin
	x1:= 0; y1:= 0;
	for i:= n1 to n do
    	if (b[i] = 1) then
        begin
        	inc(j);
        	inc(x1,x[i]);
            inc(y1,y[i]);
        end;

    if (j = 0) then exit;

    inc(cnt);
    kx[cnt]:= x1;
    ky[cnt]:= y1;
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

    for j:= 0 to 1 do
    begin
    	b[i]:= j;
        attempt2(i+1);
    end;
end;

procedure solve;
begin	
	n1:= n div 2;
	attempt1(1);

    inc(n1);
    attempt2(n1);
end;

procedure process;
var
	i,u1,v1: longint;
begin
	if (abs(u) <= maxV) and (abs(v) <= maxV) then inc(res,a[u,v]);

	for i:= 1 to cnt do
    begin
		u1:= u - kx[i];
        v1:= v - ky[i];

        if (abs(u1) > maxV) or (abs(v1) > maxV) then continue;
 		
        inc(res,a[u1,v1]);
    end;

    writeln(fo,res);
end;

begin
	assign(fi,'vector.in1'); reset(fi);
    assign(fo,'vector.out'); rewrite(fo);
	//
    input;
    solve;
    process;
    //
    close(fi);
    close(fo);
end.
