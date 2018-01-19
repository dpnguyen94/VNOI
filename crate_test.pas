uses math;
const
  outputfile = 'crate.in1';
  maxN = 300000;
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
	writeln(fo,maxN);
  for i:= 1 to maxN do
  	writeln(fo,random(100000 + 1),' ',random(100000 + 1));
end;


BEGIN
	openfile;
  gen;
  closefile;
END.
