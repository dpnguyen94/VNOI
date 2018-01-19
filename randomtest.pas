uses math;
//const
//type
var


procedure openfile;
begin
  assign(output,''); rewrite(output);
end;

procedure closefile;
begin
  close(output);
end;

procedure gen;
var
begin
end;


BEGIN
	openfile;
  gen;
  closefile;
END.
