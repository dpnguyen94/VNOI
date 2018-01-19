uses math;
const
  LM = 1000000000;
//type
//var

procedure openfile;
begin
  assign(output,'nkgolf.in1'); rewrite(output);
end;

procedure closefile;
begin
  close(output);
end;

procedure gen;
var
  i,k: longint;
begin
  writeln(500,' ',500);
  randomize;
  for i:= 1 to 1000 do
  begin
    for k:= 1 to 1000 do write(random(LM) - random(LM),' ');
    writeln;
  end;
end;


BEGIN
	openfile;
  gen;
  closefile;
END.
