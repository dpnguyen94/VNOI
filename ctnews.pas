uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 25000 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n: longint;
  x,y: int64;
  a,b,c: array[1..maxN] of longint;


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
	readln(fi,n,x,y);
  for i:= 1 to n do
  	readln(fi,a[i],b[i]);
end;

procedure sort(le,ri: longint);
var
	i,j,t,z: longint;
begin
	if (le >= ri) then exit;
  i:= le; j:= ri;
  t:= c[(le + ri) div 2];

  repeat
  	while (c[i] < t) do inc(i);
    while (c[j] > t) do dec(j);

    if (i <= j) then
    begin
			z:= c[i]; c[i]:= c[j]; c[j]:= z;

      inc(i);
      dec(j);
    end;
  until i > j;

  sort(le,j);
  sort(i,ri);
end;

procedure process;
var
	i: longint;
  res,temp: int64;
begin
	c:= a;
  sort(1,n);
  a:= c;

  c:= b;
  sort(1,n);
  b:= c;

  res:= high(int64);

  temp:= 0;
  for i:= 1 to n do
  	if (a[i] > b[i]) then
    	temp:= temp + y * (a[i] - b[i])
    else
    	temp:= temp + x * (b[i] - a[i]);
  if (temp < res) then res:= temp;

  temp:= 0;
  for i:= 1 to n do
  	if (a[i] > b[n - i + 1]) then
    	temp:= temp + y * (a[i] - b[n - i + 1])
    else
    	temp:= temp + x * (b[n - i + 1] - a[i]);
  if (temp < res) then res:= temp;

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
