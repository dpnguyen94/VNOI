uses math;
const
	inputfile = '';
    outputfile = '';
    maxV = 2010;
//type

var
	fi,fo: text;
    n,m,cnt,top,count: longint;
    a: array[1..maxV,1..maxV] of boolean;
    number,low,st,dd: array[1..maxV] of longint;
    vs: array[1..maxV] of boolean;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i,u,v: longint;
begin
	readln(fi,n,m);
    for i:= 1 to m do
    begin
    	readln(fi,u,v);
        a[u,v]:= true;
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
	v: longint;	
begin
	inc(cnt); number[u]:= cnt;
	low[u]:= number[u];
    push(u);

    for v:= 1 to n do
    begin
        if not a[u,v] or vs[v] then continue;

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
		repeat
        	v:= pop;
            inc(count);
            dd[count]:= v;
            vs[v]:= true;
        until v = u;
    end;
end;

procedure Tarjan;
var
	i: longint;
begin
	cnt:= 0;
    count:= 0;
    for i:= 1 to n do
    	if (number[i] = 0) then visit(i);
end;

procedure output;
begin
	writeln(fo,'YES');
	writeln(fo,dd[1],' ',dd[n]);
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
