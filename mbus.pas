uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 100000 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n,xn,yn: longint;
  x,y,z,c,tt: array[0..maxN] of longint;
  f,BIT: array[1..maxN] of int64;


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
	i,cnt,u,v,k: longint;
begin
	readln(fi,xn,yn,cnt);
  n:= 1;
  x[1]:= 1;
  y[1]:= 1;
  for i:= 1 to cnt do
  begin
		readln(fi,u,v,k);
    if (u >= 1) and (v >= 1) then
    begin
			inc(n);
      x[n]:= u;
      y[n]:= v;
      z[n]:= k;
    end;
  end;

  inc(n);
  x[n]:= xn;
  y[n]:= yn;
end;

procedure sortc(le,ri: longint);
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
      z:= tt[i]; tt[i]:= tt[j]; tt[j]:= z;

      inc(i);
      dec(j);
    end;
  until i > j;

	sortc(le,j);
  sortc(i,ri);
end;

procedure init;
var
	i,cnt: longint;
begin
	c:= x;
  for i:= 1 to n do tt[i]:= i;
  sortc(1,n);
  cnt:= 0;
  for i:= 1 to n do
  	if (c[i] <> c[i - 1]) then
    begin
    	inc(cnt);
      x[tt[i]]:= cnt;
    end
    else x[tt[i]]:= cnt;

	c:= y;
  for i:= 1 to n do tt[i]:= i;
  sortc(1,n);
  cnt:= 0;
  for i:= 1 to n do
  	if (c[i] <> c[i - 1]) then
    begin
    	inc(cnt);
      y[tt[i]]:= cnt;
    end
    else y[tt[i]]:= cnt;
end;

procedure sorty(le,ri: longint);
var
	i,j,t,t1,t2: longint;
begin
	if (le >= ri) then exit;
  i:= le; j:= ri;
  t1:= y[(le + ri) div 2];
  t2:= x[(le + ri) div 2];

  repeat
  	while (y[i] < t1) or ((y[i] = t1) and (x[i] < t2)) do inc(i);
    while (y[j] > t1) or ((y[j] = t1) and (x[j] > t2)) do dec(j);

    if (i <= j) then
    begin
    	t:= y[i]; y[i]:= y[j]; y[j]:= t;
      t:= x[i]; x[i]:= x[j]; x[j]:= t;
      t:= z[i]; z[i]:= z[j]; z[j]:= t;

      inc(i);
      dec(j);
    end;
  until i > j;

	sorty(le,j);
  sorty(i,ri);
end;

function getmax(x: longint): int64;
var
	temp: longint;
begin
	temp:= 0;
  while (x >= 1) do
  begin
  	if (BIT[x] > temp) then temp:= BIT[x];
    x:= x - (x and (-x));
  end;
	exit(temp);
end;

procedure update(x,val: longint);
begin
	while (x <= n) do
  begin
		if (BIT[x] < val) then BIT[x]:= val;
		x:= x + (x and (-x));
  end;
end;

procedure process;
var
	i: longint;
begin
	sorty(1,n);

  for i:= 1 to n do
  begin
		f[i]:= getmax(x[i]) + z[i];
		
    update(x[i],f[i]);
  end;

  writeln(fo,f[n]);
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  input;
  init;
  process;
  output;
  closefile;
END.
