uses math;
const
	inputfile = '';
  outputfile = '';
//type

var
	fi,fo: text;
  a1,a2,a3: longint;


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
begin
	if (a2 - a1 = a3 - a2) then
  	writeln(fo,'AP ',a3 + (a3 - a2))
  else
  	writeln(fo,'GP ',a3 * (a3 div a2));
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  while true do
  begin
  	readln(fi,a1,a2,a3);
    if (a1 = 0) and (a2 = 0) and (a3 = 0) then break;
    process;
  end;
  closefile;
END.