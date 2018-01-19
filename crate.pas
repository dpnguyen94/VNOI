uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 300000 + 10;
  maxnode = maxN;
//type

var
	fi,fo: text;
  n: longint;
  a,h,tt,c: array[0..maxN] of longint;
  f: array[0..maxnode] of longint;
  res: array[1..maxN] of longint;


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
  begin
  	readln(fi,a[i],h[i]);
    tt[i]:= i;
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
	i,j,ta,th: longint;
begin
	if (le >= ri) then exit;
  i:= le; j:= ri;
  ta:= a[(le + ri) div 2];
  th:= h[(le + ri) div 2];

  repeat
  	while (a[i] < ta) or ((a[i] = ta) and (h[i] < th)) do inc(i);
    while (a[j] > ta) or ((a[j] = ta) and (h[j] > th)) do dec(j);

    if (i <= j) then
    begin
    	swap(a[i],a[j]);
      swap(h[i],h[j]);
      swap(tt[i],tt[j]);

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
	temp:= 0;
	while (x >= 0) do
  begin
		inc(temp,f[x]);
    x:= x - (x and (-x));

    if (x = 0) then exit(temp);
  end;
end;

procedure update(x: longint);
begin
	if (x = 0) then
  begin
  	inc(f[x]);
    inc(x);
  end;
	while (x <= maxnode) do
  begin
  	inc(f[x]);	
    x:= x + (x and (-x));
  end;
end;

procedure process;
var
	i: longint;
begin
	sort(1,n);

  a[0]:= -1;
  h[0]:= -1;
  for i:= 1 to n do
  begin
  	if (a[i] = a[i - 1]) and (h[i] = h[i - 1]) then c[i]:= c[i - 1]
    else c[i]:= get(h[i]);

    update(h[i]);
  end;

  //
  for i:= 1 to n do
  	res[tt[i]]:= c[i];

  for i:= 1 to n do
  	writeln(fo,res[i]);
end;

procedure output;
begin
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
