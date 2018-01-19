uses math;
const
	inputfile = 'guess.inp';
    outputfile = 'guess.out';
    maxN = 1010;
//type

var
	fi,fo: text;
    n,test: longint;
    f: array[0..maxN] of longint;


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
begin
	readln(fi,n);
end;

procedure process;
var
	i,t: longint;
begin
	for i:= 2 to maxN do
    begin
    	f[i]:= maxlongint;
    	for t:= 1 to i-1 do
            f[i]:= min(f[i],max(f[t] + 2, f[i - t] + 1));
    end;
end;

procedure output;
begin
	writeln(fo,f[test]);
end;


BEGIN
	openfile;
    process;
    for test:= 1 to 1000 do
    begin
    	input;
        output;
    end;
    closefile;
END.
