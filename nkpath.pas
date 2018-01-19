uses math;
const
	inputfile = '';
    outputfile = '';
    LM = 110;
    C = 1000000000;
//type

var
	fi,fo: text;
	m,n: longint;
    a: array[1..LM,1..LM] of integer;
    f: array[1..LM,1..LM] of longint;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i,j: integer;
begin
	readln(fi,m,n);
    for i:= 1 to m do
    	for j:= 1 to n do
        	read(fi,a[i,j]);
end;

procedure process;
var
	i,j,u,v,x,y,r: integer;
begin
	for i:= 1 to m do
    	f[i,1]:= 1;

    for j:= 1 to n-1 do
    	for i:= 1 to m do     	
        	for u:= i to m do
            	for v:= j to n do
                	if (u > i) or (v > j) then
                    begin
						x:= a[i,j];
                        y:= a[u,v];

                        while (y > 0) do
                        begin
                        	r:= x mod y;
                            x:= y;
                            y:= r;
                        end;

                        if (x > 1) then
                            f[u,v]:= (f[u,v] + f[i,j]) mod C;
                    end;
end;

procedure output;
var
	i: integer;
    res: longint;
begin
	res:= 0;
    for i:= 1 to m do
    	res:= (res + f[i,n]) mod C;
	
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
    process;
    output;
    closefile;
end.
