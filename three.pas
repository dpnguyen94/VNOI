uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 110;
    maxM = 20010;
    maxC = 100000010;
//type

var
	fi,fo: text;
    n,m: longint;
	a,c,tr: array[1..maxN,1..maxN] of longint;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i,j,u,v,cost,count: longint;
begin
	readln(fi,n,m);
	for i:= 1 to n do
    	for j:= 1 to n do
        	if (i <> j) then c[i,j]:= maxC;

    count:= 0;
    for i:= 1 to m do
    begin
		readln(fi,u,v,cost);
        if (cost < c[u,v]) then
        begin
        	c[u,v]:= cost;
            c[v,u]:= cost;

            //
        	a[u,v]:= i;
        	a[v,u]:= i;
        end;
    end;
end;

procedure Floyd;
var
	u,v,k,t: longint;
begin
	//init;
    for u:= 1 to n do
    	for v:= 1 to n do
        	tr[u,v]:= v;

    //
    for k:= 1 to n do
    	for u:= 1 to n do
        	for v:= 1 to n do
            begin
            	t:= c[u,k] + c[k,v];
            	if (c[u,v] > t) then
                begin
                	c[u,v]:= t;
                    tr[u,v]:= tr[u,k];
                end;
            end;
end;

procedure output;
var
	i,res,t,count,u,v: longint;
    dd: array[0..maxM] of boolean;
begin
	res:= maxC;
	for i:= 1 to n do
    begin
    	t:= c[1,i] + c[2,i] + c[3,i];
		if (t < res) then
        begin
        	res:= t;
            v:= i;
        end;
    end;
    writeln(fo,res);

    for i:= 1 to 3 do
    begin
    	u:= i;
        repeat
			dd[a[u,tr[u,v]]]:= true;
            u:= tr[u,v];
        until u = v;
    end;

    //
    count:= 0;
    for i:= 1 to m do
    	if dd[i] then inc(count);

    //
    writeln(fo,count);
	for i:= 1 to m do
    	if dd[i] then
    		write(fo,i,' ');
end;

procedure closefile;
begin
	close(fi);
    close(fo);
end;


begin
	openfile;
    input;
    Floyd;
    output;
    closefile;
end.
