uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 50010;
//type

var
	fi,fo: text;
    n: longint;
	a,amin,amax: array[1..maxN] of longint;	


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var	
	i,j: longint;
begin
	n:= 0;
    while not seekeoln(fi) do
    begin
    	read(fi,j);
    	inc(n);
        a[n]:= j;
    end;
end;

procedure output;
begin
	writeln(fo,'NO');
    close(fo);
    halt;
end;


procedure dfs(i: longint);
begin
	amin[i]:= a[i];
    amax[i]:= a[i];

    //
    if (i = n) then exit;

    //
    dfs(i+1);
    amin[i]:= min(amin[i],amin[i+1]);
    amax[i]:= max(amin[i],amax[i+1]);

	if (a[i+1] > a[i]) then
	begin
    	if (a[i] > amin[i]) then output;
    end
    else
    	if (a[i] < amax[i]) then output;
end;

procedure process;
begin
	dfs(1);
    writeln(fo,'YES');
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
    closefile;
end.
