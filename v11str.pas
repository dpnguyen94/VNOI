uses math;
const
	inputfile = '';
  outputfile = '';
  maxP = 1000 + 10;
  maxT = 500000 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  np,nt: longint;
  p: array[1..maxP] of longint;
  t: array[1..maxT] of longint;


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
var
	i: longint;
begin
	readln(fi,np,nt);
	for i:= 1 to np do
  	read(fi,p[i]);
  for i:= 1 to nt do
  	read(fi,t[i]);
end;

procedure process;
var
	i,j,cnt: longint;
begin
  for i:= 1 to nt - np + 1 do
  begin
  	cnt:= 0;
		for j:= i to i + np - 1 do
    	if (t[j] <> p[j - i + 1]) then
      begin
      	inc(cnt);
        if (cnt >= 2) then break;
      end;

    if (cnt <= 1) then
    begin
    	writeln(fo,i);
      exit;
    end;
  end;

  writeln(fo,-1);
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
