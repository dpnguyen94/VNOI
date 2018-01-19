uses math;
const
	inputfile = 'circle.inp';
    outputfile = 'circle.out';
    maxN = 31;
    //''
//type

var
	fi,fo: text;
    n: longint;
    f: array[0..2 * maxN] of int64;


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
	t,p: longint;
begin
	n:= 2 * n;
    f[0]:= 1;
	for t:= 2 to n do
    	if (t mod 2 = 0) then
        begin
			for p:= 2 to t do
            	if (p mod 2 = 0) then
					f[t]:= f[t] + f[p - 2] * f[t - p];
        end;
end;

procedure output;
begin
	writeln(fo,f[n]);
end;


BEGIN
	openfile;
    input;
    process;
    output;
    closefile;
END.
