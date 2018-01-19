uses math;
const
	inputfile = '';
  outputfile = '';
//type

var
	fi,fo: text;
  ntest,test: longint;
  n: longint;


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
	res,temp: int64;
begin
	res:= 0;
  temp:= 5;
  while (temp <= n) do
  begin
		res:= res + n div temp;
    temp:= temp * 5;
  end;

  writeln(fo,res);
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  readln(fi,ntest);
  for test:= 1 to ntest do
  begin
  	input;
    process;
  end;
  closefile;
END.
