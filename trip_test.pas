uses math;
const
  outputfile = 'trip.inp';
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
	i,n,m: longint;
begin
	writeln(fo,1);
	for i:= 1 to 80 do
  	write(fo,chr(97 + random(26)));
  writeln(fo);
  for i:= 1 to 80 do
  	write(fo,chr(97 + random(26)));
end;


BEGIN
	openfile;
  gen;
  closefile;
END.
