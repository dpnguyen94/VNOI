uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 500000 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n: longint;
  f: array[1..maxN] of int64;


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
	i,j: longint;
begin
	for i:= 1 to maxN div 2 do
  begin
		j:= i + i;
    while (j < maxN) do
    begin
			f[j]:= f[j] + i;
      j:= j + i;
    end;
  end;
end;

procedure output;
begin
	writeln(fo,f[n]);
end;


BEGIN
	openfile;
  process;
  readln(fi,ntest);
  for test:= 1 to ntest do
  begin
  	input;
    output;
  end;
  closefile;
END.
