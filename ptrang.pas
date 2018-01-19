uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 6010;
//type

var
	fi,fo: text;
    n,l: longint;
    w,f: array[0..maxN] of longint;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i: longint;
begin
	readln(fi,n,l);
    for i:= 1 to n do
    begin
    	readln(fi,w[i]);
        w[i]:= w[i-1] + w[i];
    end;
end;

procedure process;
var
	i,j: longint;
begin
	for i:= 1 to n do
	begin
		f[i]:= maxlongint;
        for j:= i-1 downto 0 do
        begin
        	if (w[i] - w[j] > l) then break;
            f[i]:= min(f[i],max(f[j],l - (w[i] - w[j])));
        end;
    end;
end;


procedure output;
begin
	writeln(fo,f[n]);
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
