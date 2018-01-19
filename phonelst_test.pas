uses math;
const
  outputfile = 'phonelst.in1';
  maxtest = 40;
//type
var
	fo: text;
  n: longint;


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
	i,j,t,leng: longint;
begin
	randomize;
	writeln(fo,maxtest);
  for i:= 1 to maxtest do
  begin
  	n:= random(1000) + 1;
    n:= 10000;
  	writeln(fo,n);

    for j:= 1 to n do
    begin
    	leng:= random(10) + 1;
      leng:= 10;
      for t:= 1 to leng do
      	write(fo,chr(random(10) + 48));
      writeln(fo);
    end;
  end;
end;


BEGIN
	openfile;
  gen;
  closefile;
END.
