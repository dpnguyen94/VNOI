uses math;
const
	inputfile = '';
  outputfile = '';
//type

var
	fi,fo: text;
  g,b: longint;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
  assign(fo,outputfile); rewrite(fo);
end;

procedure closefile;
begin
	close(fi);
  close(fo);
end;

procedure input;
//var
begin
end;

procedure process;
var
	temp,res: longint;
begin
	if (g = b) then
  begin
  	if (g = 0) and (b = 0) then res:= 0
    else res:= 1;

  	writeln(fo,res);
    exit;
  end;

  if (g > b) then
  begin
  	temp:= g;
    g:= b;
    b:= temp;
  end;

	inc(g);
	res:= b div g;
  if (b mod g > 0) then inc(res);

  writeln(fo,res);
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  while true do
  begin
  	readln(fi,g,b);
    if (g = -1) then break;
    process;
  end;
  closefile;
END.
