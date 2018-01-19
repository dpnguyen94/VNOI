uses math;
const
	inputfile = '';
    outputfile = '';
    maxC = 5;
    maxN = 110;
type
	card = record
        color,val: longint;
    end;
var
	fi,fo: text;
    c,n,res: longint;
    a: array[1..maxC * maxN] of card;
    b,f: array[1..maxC * maxN] of longint;
    pos: array[1..maxC] of longint;
    vs: array[1..maxC] of boolean;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;


procedure closefile;
begin
	close(fi);
    close(fo);
end;


procedure input;
var
	i: longint;
begin
	readln(fi,c,n);
    for i:= 1 to c * n do
        readln(fi,a[i].color,a[i].val);
end;


procedure solve;
var
	i,j,t,rmax: longint;
begin
	t:= c * n;
	for i:= 1 to t do
        b[i]:= pos[a[i].color] * 1000 + a[i].val;

    for i:= 1 to t do f[i]:= 1;

    rmax:= 1;
    for i:= 2 to t do
    	for j:= i-1 downto 1 do 	
        	if (b[j] < b[i]) then
            begin
        		f[i]:= max(f[i],f[j]+1);
                rmax:= max(rmax,f[i]);
            end;

	res:= min(res,t - rmax);
end;


procedure attempt(i: longint);
var
	j: longint;
begin
	if (i > c) then
    begin
    	solve;
        exit;
    end;

    for j:= 1 to c do
    	if not vs[j] then
        begin
		    pos[i]:= j;
            vs[j]:= true;
            attempt(i+1);
            vs[j]:= false;
        end;
end;


procedure process;
begin
	res:= maxlongint;
	attempt(1);
end;


procedure output;
begin
	writeln(fo,res);
end;


begin
	openfile;
    input;
    process;
    output;
    closefile;
end.
