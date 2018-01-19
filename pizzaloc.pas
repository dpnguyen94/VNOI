uses math;
const
	inputfile = '';
  outputfile = '';
  maxK = 10 + 5;
  maxM = 20 + 5;
  maxN = 100 + 10;
type
	point = record
  	x,y: longint;
  end;
var
	fi,fo: text;
  ntest,test: longint;
  k,r,m,n,res: longint;
  a: array[1..maxM] of point;
  b: array[1..maxN] of point;
  num: array[1..maxN] of longint;

  c: array[1..maxM,1..maxN] of boolean;
  f: array[1..maxM] of longint;
  x: array[0..maxK] of longint;


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
	readln(fi,k,r);
  readln(fi,m);
	for i:= 1 to m do
  	readln(fi,a[i].x,a[i].y);

  readln(fi,n);
  for i:= 1 to n do
  	readln(fi,b[i].x,b[i].y,num[i]);
end;

procedure solve;
var
	i,v,temp: longint;
begin
  temp:= 0;
  for v:= 1 to n do
  	for i:= 1 to k do
			if c[x[i],v] then
      begin
      	temp:= temp + num[v];
        break;
      end;	

  res:= max(res,temp);
end;

procedure attempt(i,sum: longint);
var
	j: longint;
begin
	if (i > k) then
  begin
  	if (sum > res) then solve;
    exit;
	end;

  for j:= x[i - 1] + 1 to m - k + i do
  begin
  	x[i]:= j;
    attempt(i + 1,sum + f[j]);
  end;
end;

function dist(i,j: longint): longint;
begin
	exit(sqr(a[i].x - b[j].x) + sqr(a[i].y - b[j].y));
end;

procedure process;
var
	i,j: longint;
begin
	for i:= 1 to m do
  	for j:= 1 to n do
    	if (dist(i,j) <= r * r) then
      begin
      	c[i,j]:= true;
        f[i]:= f[i] + num[j];
      end;

  res:= 0;
	attempt(1,0);
end;

procedure output;
begin
	writeln(fo,res);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
