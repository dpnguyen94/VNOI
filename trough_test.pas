uses math;
const
  outputfile = 'trough.in1';
  maxN = 20;
  maxM = 100;
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
	i,j: longint;
begin
	writeln(fo,maxN,' ',maxM);
  for i:= 1 to maxM do
  begin
  	for j:= 1 to maxN do
    	write(fo,random(2));
    writeln(fo,' ',random(maxN + 1));
  end;
end;


BEGIN
	openfile;
  gen;
  closefile;
END.
