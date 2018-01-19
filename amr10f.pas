uses math;
const
	inputfile = '';
  outputfile = '';
//type

var
	fi,fo: text;
  ntest,test: longint;
  n,a,d: longint;


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
	readln(fi,n,a,d);
end;

procedure process;
var
	i,sum: longint;
begin
	sum:= a;
  for i:= 2 to n do
  begin
  	a:= a + d;
    sum:= sum + a;
  end;

  writeln(fo,sum);
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
