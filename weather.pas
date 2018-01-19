uses math;
const
	maxN = 110;
    maxM = 5010;
//type

var                                	
	fi,fo: text;
	a: array[1..maxN,1..maxN] of longint;
    x,y: array[1..maxM] of longint;
    vs: array[1..maxN] of boolean;
    cnt: array[1..2] of longint;
    n,m,count,res: longint;


procedure input;
var
	i,j: longint;
begin
	readln(fi,n);
    readln(fi,m);

    for i:= 1 to m do
    begin
    	readln(fi,x[i],y[i]);
        a[x[i],y[i]]:= 1;
        a[y[i],x[i]]:= 1;
    end;
end;

procedure dfs(i: longint);
var
	j: longint;
begin
	vs[i]:= true;
    inc(cnt[count]);

    //
	for j:= 1 to n do
    	if (a[i,j] = 1) and (not vs[j]) then dfs(j);
end;

procedure solve;
var               	
	i,j: longint;
begin
	fillchar(vs,sizeof(vs),false);
    fillchar(cnt,sizeof(cnt),0);

    count:= 0;
	for i:= 1 to n do
    	if (not vs[i]) then
        begin
        	inc(count);	
            cnt[count]:= 0;
            dfs(i);
        end;

	inc(res,cnt[1]*cnt[2]);
end;

procedure process;
var
	i: longint;
begin
	res:= 0;	
	for i:= 1 to m do
    begin
    	a[x[i],y[i]]:= 0;
        a[y[i],x[i]]:= 0;
        solve;
        a[x[i],y[i]]:= 1;
        a[y[i],x[i]]:= 1;
    end;

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
