uses math;
const
	inputfile = '';
  outputfile = '';
type
	int1 = longint;
  int2 = int64;
  bool = boolean;
var
	fi,fo: text;
	l,r: int2;
  ntest,test,k: int1;


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
	readln(fi,l,r);
end;

function power(n,m: int1): int2;
var
	tmp: int2;
begin
	if (m = 1) then exit(n);

  tmp:= power(n,m div 2);
  tmp:= tmp * tmp;
  if (m mod 2 = 1) then tmp:= tmp * n;

  exit(tmp);
end;

procedure process;
var
	x,t: int1;
begin
	for k:= 40 downto 1 do
  begin
  	t:= trunc(exp(ln(r)/k));
    if (power(t,k) >= l) then exit;
  end;
end;

procedure output;
begin
	write(fo,k);
  writeln(fo);
end;


BEGIN
	openfile;
  readln(fi,ntest);
  for test:= 1 to ntest do
  begin
  	input;
    write(fo,'Case #',test,': ');
  	process;
  	output;
  end;
  closefile;
END.
