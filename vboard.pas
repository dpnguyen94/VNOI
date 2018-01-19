uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 510;
//type

var
	fi,fo: text;
    n,q: longint;
	a,fb,fw: array[0..maxN,0..maxN] of longint;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i,j: longint;
begin
	readln(fi,n);
    for i:= 1 to n do
    	for j:= 1 to n do
        begin
            read(fi,a[i,j]);
        	
        	if ((i + j) mod 2 = 0) then
            begin
                fw[i,j]:= fw[i-1,j] + fw[i,j-1] - fw[i-1,j-1] + a[i,j];
                fb[i,j]:= fb[i-1,j] + fb[i,j-1] - fb[i-1,j-1];
            end
            else
            begin
				fb[i,j]:= fb[i-1,j] + fb[i,j-1] - fb[i-1,j-1] + a[i,j];
                fw[i,j]:= fw[i-1,j] + fw[i,j-1] - fw[i-1,j-1];
            end;
        end;
end;

procedure process;
var
	i,i1,j1,i2,j2,res1,res2: longint;
begin
	readln(fi,q);
    for i:= 1 to q do
    begin
    	readln(fi,i1,j1,i2,j2);
        res1:= fw[i2,j2] - fw[i1-1,j2] - fw[i2,j1-1] + fw[i1-1,j1-1];
        res2:= fb[i2,j2] - fb[i1-1,j2] - fb[i2,j1-1] + fb[i1-1,j1-1];

        writeln(fo,abs(res1 - res2));
    end;
end;

procedure output;
begin
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
