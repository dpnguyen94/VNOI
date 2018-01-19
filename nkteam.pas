uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 100000 + 10;
  maxnode = maxN;
//type

var
	fi,fo: text;
  n: longint;
	a,b,c: array[1..maxN] of longint;
  f: array[1..maxnode] of longint;


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
	i,j: longint;
begin
	readln(fi,n);
  for i:= 1 to n do
  begin
  	read(fi,j);
		a[j]:= i;
  end;
  for i:= 1 to n do
  begin
  	read(fi,j);
		b[j]:= i;
  end;
  for i:= 1 to n do
  begin
  	read(fi,j);
		c[j]:= i;
  end;
end;

procedure swap(var x,y: longint);
var
	z: longint;
begin
	z:= x;
  x:= y;
  y:= z;
end;

procedure sort(le,ri: longint);
var
	i,j,t: longint;
begin
	if (le >= ri) then exit;
  i:= le; j:= ri;
  t:= a[(le + ri) div 2];

  repeat
  	while (a[i] < t) do inc(i);
    while (a[j] > t) do dec(j);

    if (i <= j) then
    begin
    	swap(a[i],a[j]);
      swap(b[i],b[j]);
      swap(c[i],c[j]);

      inc(i);
      dec(j);
    end;
  until i > j;

  sort(le,j);
  sort(i,ri);
end;

function get(x: longint): longint;
var
	temp: longint;
begin
	temp:= maxlongint;
  while (x > 0) do
  begin
		temp:= min(temp,f[x]);
		x:= x - (x and (-x));
  end;

  exit(temp);
end;

procedure update(x,val: longint);
begin
	while (x <= maxnode) do
  begin
		f[x]:= min(f[x],val);
    x:= x + (x and (-x));
  end;
end;

procedure process;
var
	i,res: longint;
begin
	for i:= 1 to maxnode do
  	f[i]:= maxlongint;

	//
  sort(1,n);

	//
  res:= 0;
  for i:= 1 to n do
  begin
  	if (get(b[i] - 1) > c[i]) then inc(res);
    update(b[i],c[i]);
  end;

  //
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
