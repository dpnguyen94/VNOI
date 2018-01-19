uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 40;
//type

var
	fi,fo: text;
   	ntest,test,n: longint;
	a,res: array[1..maxN] of longint;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	s: string;
    i: longint;
begin
	readln(fi,s);
    n:= length(s);
    for i:= 1 to n do
    	if (s[i] = '1') then a[i]:= 1
        else a[i]:= 0;
end;

procedure process;
var
	i: longint;	
begin
	res[1]:= 1;
    for i:= 2 to n do
    	if (a[i] = 1) then res[i]:= (res[i-1] + 1) mod 2
        else res[i]:= res[i-1];
end;

procedure output;
var
	nres,i,t: longint;
begin
	nres:= 0;
    t:= 1;
    for i:= n downto 1 do
    begin
    	nres:= nres + res[i] * t;
        t:= t * 2;
    end;

    if (a[1] = 0) then writeln(fo,0)
    else writeln(fo,nres);
end;

procedure closefile;
begin
	close(fi);
    close(fo);
end;


begin
	openfile;
    readln(fi,ntest);
    for test:= 1 to ntest do
    begin
    	input;
    	process;
    	output;
    end;
    closefile;
end.
