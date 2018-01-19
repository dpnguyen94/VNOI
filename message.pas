uses math;
const
	maxN = 810;
//type

var
	fi,fo: text;
    n,m,cnt,cpn,res: longint;
    a,b: array[1..maxN,1..maxN] of boolean;
    vs: array[1..maxN] of boolean;
    st,number,low,c: array[1..maxN] of longint;
    top: longint;

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

procedure visit(i: longint);
var
 	j: longint;
begin
	inc(cnt); number[i]:= cnt;
    low[i]:= number[i];

    inc(top);
    st[top]:= i;

    for j:= 1 to n do
    	if (not vs[j]) and (a[i,j]) then
        	if number[j] <> 0 then
            	low[i]:= min(low[i],number[j])
            else
            begin
            	visit(j);
                low[i]:= min(low[i],low[j]);
            end;

    if (number[i] = low[i]) then
    begin
    	inc(cpn);
        repeat
        	j:= st[top];
        	dec(top);
            write(fo,j,' ');

            c[j]:= cpn;

            vs[j]:= true;
        until j = i;
        writeln(fo);
    end;
end;

procedure process1;
var
	i: longint;
begin
	for i:= 1 to n do
    	if (number[i] = 0) then visit(i);
end;

procedure process2;
var
	i,j: longint;
begin
	for i:= 1 to n do
    	for j:= 1 to n do
        	if (a[i,j]) and (c[i] <> c[j]) then b[c[i],c[j]]:= true;

    for i:= 1 to cpn do
    begin
    	cnt:= 0;
    	for j:= 1 to cpn do
        	if (b[j,i]) then inc(cnt);

        //
        if (cnt = 0) then inc(res);
    end;
end;

procedure output;
begin
	writeln(fo,res);
end;


begin
	assign(fi,'message.in'); reset(fi);
    assign(fo,'message.out'); rewrite(fo);
    //
    input;
    process1;
    //process2;
    //output;
    //
    close(fi);
    close(fo);
end.
