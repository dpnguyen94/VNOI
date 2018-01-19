uses math;
const
  outputfile = 'totalodd.in1';
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
	for i:= 1 to 50 do
  begin
  	writeln(fo,'[CASE]');
    writeln(fo,random(100000000));
    writeln(fo);
  end;

  writeln(fo,'[END]');
end;


BEGIN
	openfile;
  gen;
  closefile;
END.
