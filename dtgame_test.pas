uses math;
//const
//type


procedure openfile;
begin
  assign(output,'dtgame.in1'); rewrite(output);
end;

procedure closefile;
begin
  close(output);
end;

procedure gen;
var
  i: longint;
begin
  writeln(2000);
  for i:= 1 to 2000 do writeln(random(1000) + 1);
end;


BEGIN
	openfile;
  gen;
  closefile;
END.
