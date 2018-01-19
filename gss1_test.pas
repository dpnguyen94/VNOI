uses math;
const
  outputfile = 'gss1.in1';
  maxN = 50000;
  LM = 15000;
  maxQ = 10000;
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
	i,u,v: longint;
begin
	randomize;
	writeln(fo,maxN);
	for i:= 1 to maxN do
  begin
		write(fo,random(LM + 1) - random(LM + 1),' ');
  end;
  writeln(fo);
  writeln(fo,maxQ);
  for i:= 1 to maxQ do
  begin
		u:= random(maxN div 2 - 5) + 1;
    v:= u + random(maxN div 2);

    writeln(fo,u,' ',v);
  end;
end;


BEGIN
	openfile;
  gen;
  closefile;
END.
