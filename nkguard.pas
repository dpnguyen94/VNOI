uses math;
const
	LM = 710;
//type
var
	fi,fo: text;
    a: array[0..LM,0..LM] of longint;
    b: array[0..LM,0..LM] of boolean;
    g: array[1..500000] of boolean;
    n,m,cnt,h: longint;
    dx: array[1..8] of longint = (0,0,1,1,1,-1,-1,-1);
    dy: array[1..8] of longint = (1,-1,-1,0,1,-1,0,1);


procedure input;
var  	i,j: longint;
begin
	readln(fi,n,m);
    for i:= 1 to n do
    	for j:= 1 to m do read(fi,a[i,j]);
end;


procedure ffill(x,y: longint);
var	x1,y1,k: longint;
begin
	if (x = 0) or (y = 0) or (x = n+1) or (y = m+1) then exit;
    if (b[x,y]) then exit;

    //
    b[x,y]:= true;
	for k:= 1 to 8 do
    begin
    	x1:= x+ dx[k]; y1:= y+dy[k];
    	if (a[x1,y1] > h) then g[cnt]:= false;
    	if (a[x1,y1] = h) then ffill(x1,y1);
    end;
end;


procedure process;
var	i,j,res: longint;
begin
	fillchar(g,sizeof(g),true);
	cnt:= 0;
	for i:= 1 to n do
    	for j:= 1 to m do
			if not b[i,j] then
            begin
				inc(cnt);
                h:= a[i,j];
				ffill(i,j);
            end;

	res:= 0;
    for i:= 1 to cnt do if g[i] then inc(res);

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
