uses math;
const
	fi = '';
    fo = '';
var
	a: array[1..100010] of longint;
    b: array[1..110,1..110] of longint;
    n,m: longint;
    f: text;


procedure nhap;
var
	i,j: longint;
begin
	assign(f,fi); reset(f);
    readln(f,n,m);
    for i:= 1 to m do readln(f,a[i]);
    	for i:= 1 to n do
        begin
        	for j:= 1 to n do read(f,b[i,j]);
    		readln(f);
        end;
    close(f);
end;

procedure xuli;
var
    u,v: byte;
    d,k: longint;
begin
	//floyd;
	for k:= 1 to n do
    	for u:= 1 to n do
        	for v:= 1 to n do
            	if b[u,v] > b[u,k] + b[k,v] then
                	b[u,v]:= b[u,k] + b[k,v];
    //
    d:= 0;
    for k:= 1 to m-1 do d:= d + b[a[k],a[k+1]];
    //
    assign(f,fo); rewrite(f);
    writeln(f,d);
    close(f);
end;


begin
	nhap;
    xuli;
end.
