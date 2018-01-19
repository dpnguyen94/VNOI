uses math;
const
	inputfile = '';
  outputfile = '';
//type

var
	fi,fo: text;
  ntest,test: longint;
  n,m: longint;
	

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
	readln(fi,n,m);
end;

procedure process;
var
	res: longint;
begin
	res:= (n - m) and ((m - 1) div 2);
  if (res = 0) then writeln(fo,1)
  else writeln(fo,0);
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
