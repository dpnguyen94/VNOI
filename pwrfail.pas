uses math;
const
	inputfile = 'pwrfail.inp';
  outputfile = 'pwrfail.out';

//type

var
	fi,fo: text;
  ntest,test: longint;


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
var
begin
end;

procedure process;
var
begin
end;

procedure output;
var
begin
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
