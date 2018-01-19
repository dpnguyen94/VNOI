uses math;
const
	inputfile = 'permute.inp';
    outputfile = 'permute.out';
    maxN = 110;
    base = 1000000000;
//type

var
	fi,fo: text;
    n: longint;
    f1,f2: array[-1..maxN,-1..maxN] of longint;


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
	i,j,k: longint;
begin
	for i:= 0 to n-1 do
    begin
    	f1[1,i]:= 1;
        f2[1,i]:= 1;
    end;

    for i:= 1 to n do
    	for j:= 0 to n-1 do
        begin
			for k:= 1 to n-i-j do
          		f2[i+1,j+(k-1)]:= (f2[i+1,j+(k-1)] + f1[i,j]) mod base;
            for k:= 0 to j-1 do
            	f1[i+1,k]:= (f1[i+1,k] + f2[i,j]) mod base;
        end;
end;

procedure output;
var
	res: longint;
begin
	res:= (f1[n,0] + f2[n,0]) mod base;
    writeln(fo,res);
end;


begin
	openfile;
    input;
    process;
    output;
    closefile;
end.
