uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 5010;
//type

var
	fi,fo: text;
    n,res: integer;
    a,b: array[1..maxN] of integer;
    f: array[0..maxN,0..maxN] of integer;

procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i: integer;
begin
	readln(fi,n);
    for i:= 1 to n do
    	read(fi,a[i]);
end;

procedure process;
var
	i,j: integer;
begin
	for i:= 2 to n do
    	b[i]:= a[i] - a[i-1];
	
    for i:= 3 to n do
    	for j:= i-1 downto 2 do
        	if (b[i] = b[j]) then
            begin
            	f[i,j]:= f[i-1,j-1] + 1;
                res:= max(res,min(f[i,j],i - j - 1));
            end;
end;

procedure output;
begin
	inc(res);
    if (res >= 5) then writeln(fo,res)
    else writeln(fo,0);
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
