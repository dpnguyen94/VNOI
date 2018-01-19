uses math;
const
  outputfile = 'haoi5000.in1';
  maxN = 1000000;
  maxK = 100000;
//type
var
	fo: text;


procedure openfile;
begin
  assign(fo,outputfile); rewrite(fo);
end;

procedure closefile;
begin
  close(fo);
end;

procedure gen;
var
	i: longint;
begin
	randomize;
	writeln(fo,maxN,' ',maxK);
	for i:= 1 to maxK do
  	write(fo,random(maxN) + 1,' ');
end;


BEGIN
	openfile;
  gen;
  closefile;
END.
