uses math;
const
  outputfile = 'aladdin.in1';
  maxN = 200;
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
	writeln(fo,maxN);
  randomize;
	for i:= 1 to maxN - 1 do
  begin
  	for j:= 1 to maxN - 1 do 	
    	write(fo,random(5),' ');
    writeln(fo);
  end;
end;


BEGIN
	openfile;
  gen;
  closefile;
END.
