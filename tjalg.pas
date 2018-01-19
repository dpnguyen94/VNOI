uses math;
const
	inputfile = '';
    outputfile = '';
    maxE = 100010;
    maxV = 10010;
//type

var
	fi,fo: text;
    n,m,cnt,top,res: longint;
    a,x,y: array[1..maxE] of longint;
    h,number,low,st: array[1..maxV] of longint;
    vs: array[1..maxV] of boolean;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i: longint;
begin
	readln(fi,n,m);
    for i:= 1 to m do
    begin
    	readln(fi,x[i],y[i]);
        inc(h[x[i]]);
    end;

    for i:= 2 to n+1 do
    	h[i]:= h[i-1] + h[i];

    for i:= 1 to m do
    begin
    	a[h[x[i]]]:= y[i];
        dec(h[x[i]]);
	end;
end;

procedure push(u: longint);
begin
	inc(top);
    st[top]:= u;
end;

function pop: longint;
begin
	pop:= st[top];
    dec(top);
end;

procedure visit(u: longint);
var
	i,v: longint;	
begin
	inc(cnt); number[u]:= cnt;
	low[u]:= number[u];
    push(u);

    for i:= h[u] + 1 to h[u+1] do
    begin
    	v:= a[i];
        if (vs[v]) then continue;

        if (number[v] <> 0) then
        	low[u]:= min(low[u],number[v])
        else
        begin
			visit(v);
            low[u]:= min(low[u],low[v]);
        end;
    end;

    if (low[u] = number[u]) then
    begin
    	inc(res);
		repeat
        	v:= pop;
            vs[v]:= true;
        until v = u;
    end;
end;

procedure Tarjan;
var
	i: longint;
begin
	res:= 0;

	cnt:= 0;
    for i:= 1 to n do
    	if (number[i] = 0) then visit(i);
end;

procedure output;
begin
	writeln(fo,res);
end;

procedure closefile;
begin
	close(fi);
    close(fo);
end;

begin
	openfile;
    input;
    Tarjan;
    output;
    closefile;
end.
