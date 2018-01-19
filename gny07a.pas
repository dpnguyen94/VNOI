uses math;
const
	inputfile = '';
  outputfile = '';
//type

var
	fi,fo: text;
  ntest,test: longint;
  m: longint;
  s: string;


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
//var
begin
end;

procedure process;
var
	i: longint;
  ch: char;
begin
	read(fi,m);
  readln(fi,s);
  delete(s,1,1);
  delete(s,m,1);

  writeln(fo,s);
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
  	write(fo,test,' ');
  	process;
  end;
  closefile;
END.
