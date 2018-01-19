uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 100000 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n: longint;
  a,max1,max2: array[0..maxN] of longint;
  res: int64;


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
	readln(fi,n);
  for i:= 1 to n do
  	read(fi,a[i]);
end;

procedure process;
var
	i: longint;
begin
	for i:= 1 to n do
  	max1[i]:= max(max1[i - 1],a[i]);
  for i:= n downto 1 do
  	max2[i]:= max(max2[i + 1],a[i]);

  res:= 0;
  for i:= 1 to n do
  begin
  	if (max1[i - 1] <= a[i]) or (max2[i + 1] <= a[i]) then continue;

    res:= res + min(max1[i - 1],max2[i + 1]) - a[i];
  end;

  writeln(fo,res);
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
