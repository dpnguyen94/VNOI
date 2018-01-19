uses math;
const
  outputfile = 'posters.in1';
  maxtest = 5;
  maxN = 40000;
  LM = 10000000;
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
	i,j,u,v: longint;
begin
	writeln(fo,maxtest);

  for i:= 1 to maxtest do
  begin
		writeln(fo,maxN);
    for j:= 1 to maxN do
    begin
    	u:= random(LM div 2 - 5) + 1;
      v:= u + random(LM div 2);

      writeln(fo,u,' ',v);
    end;
  end;
end;


BEGIN
	openfile;
  gen;
  closefile;
END.
