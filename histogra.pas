uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 100000 + 10;
//type

var
	fi,fo: text;
  n: longint;
  h,left,right: array[0..maxN] of longint;


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
  for i:= 1 to n do
  	read(fi,h[i]);
end;

procedure process;
var
	i,j: longint;
begin
	h[0]:= -maxlongint;
  h[n + 1]:= -maxlongint;

	for i:= 1 to n do
  begin
  	left[i]:= i - 1;

    j:= left[i];
    while (h[j] >= h[i]) do j:= left[j];
    left[i]:= j;
  end;

  for i:= n downto 1 do
  begin
  	right[i]:= i + 1;

    j:= right[i];
    while (h[j] >= h[i]) do j:= right[j];
    right[i]:= j;
  end;
end;

procedure output;
var
	i: longint;
  res,temp: int64;
begin
	res:= 0;
	for i:= 1 to n do
  begin
		temp:= int64(h[i]) * (right[i] - left[i] - 1);
    if (temp > res) then res:= temp;
  end;

  writeln(fo,res);
end;


BEGIN
	openfile;
  while true do
  begin
  	read(fi,n);
    if (n = 0) then break;
    input;
    process;
    output;
  end;
  closefile;
END.
