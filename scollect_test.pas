uses math;
//const
//type
//var

procedure openfile;
begin
  assign(output,'scollect.in1'); rewrite(output);
end;

procedure closefile;
begin
  close(output);
end;

procedure gen;
var
  i,k,x: longint;
begin
  writeln(128,' ',128);
  for i:= 1 to 128 do
  begin
    for k:= 1 to 128 do
    begin
      x:= random(3);
      if (x = 0) then write('*');
      if (x = 1) then write('*');
      if (x = 2) then write('*');
    end;
    writeln;
  end;
end;


BEGIN
	openfile;
  gen;
  closefile;
END.
