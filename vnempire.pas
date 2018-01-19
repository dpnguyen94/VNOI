uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 100000 + 10;
  maxC = maxlongint;
//type

var
	fi,fo: text;
  n,m: longint;
  g: array[1..maxN,1..3] of longint;
  c,tt: array[1..maxN] of longint;

  x,y,l1: array[1..3 * maxN] of longint;
  h: array[1..maxN] of longint;
  a,l: array[1..6 * maxN] of longint;

  vs: array[1..maxN] of boolean;
  d,heap,pos: array[1..maxN] of longint;
  nheap: longint;


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
  	for j:= 1 to 3 do
    	read(fi,g[i,j]);
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
    	swap(c[i],c[j]);
      swap(tt[i],tt[j]);

      inc(i);
      dec(j);
    end;
  until i > j;

  sort(le,j);
  sort(i,ri);
end;

procedure init;
var
	i,j: longint;
begin
	m:= 0;
	for i:= 1 to 3 do
  begin
  	for j:= 1 to n do 	
    	tt[j]:= j;
		for j:= 1 to n do
    	c[j]:= g[j,i];

    //
    sort(1,n);

    //
    for j:= 1 to n - 1 do
    begin
    	inc(m);
      x[m]:= tt[j];
      y[m]:= tt[j + 1];
      l1[m]:= abs(c[j + 1] - c[j]);
    end;
  end;
end;

procedure build;
var
	i,u,v: longint;
begin
	fillchar(h,sizeof(h),0);
	for i:= 1 to m do
  begin
  	inc(h[x[i]]);
    inc(h[y[i]]);
  end;

  for i:= 2 to n + 1 do
  	h[i]:= h[i - 1] + h[i];

  for i:= 1 to m do
  begin
		u:= x[i];
    v:= y[i];

    a[h[u]]:= v;
    a[h[v]]:= u;
    l[h[u]]:= l1[i];
    l[h[v]]:= l1[i];

    dec(h[u]);
    dec(h[v]);
  end;
end;

function pop: longint;
var
	i,p,c: longint;
begin
	pop:= heap[1];

  i:= heap[nheap];
  dec(nheap);

	p:= 1;
  repeat
    c:= p * 2;
    if (c < nheap) and (d[heap[c]] > d[heap[c+1]]) then inc(c);
    if (c > nheap) or (d[i] <= d[heap[c]]) then break;

    heap[p]:= heap[c];
  	pos[heap[p]]:= p;
    p:= c;
  until FALSE;

  heap[p]:= i;
  pos[i]:= p;
end;

procedure update(ps: longint);
var
	i,c,p: longint;
begin
	i:= heap[ps];

  c:= ps;
  repeat
  	p:= c div 2;
    if (p = 0) or (d[i] >= d[heap[p]]) then break;

    heap[c]:= heap[p];
    pos[heap[c]]:= c;
    c:= p;
  until FALSE;

  heap[c]:= i;
  pos[i]:= c;
end;

procedure prim;
var
	i,u,v: longint;
begin
	d[1]:= 0;
  heap[1]:= 1;
  pos[1]:= 1;
  nheap:= n;

  for i:= 2 to n do
  begin
  	d[i]:= maxC;
    heap[i]:= i;
    pos[i]:= i;
  end;

  repeat
		u:= pop;
    if (nheap = 0) then exit;
		vs[u]:= true;

    for i:= h[u] + 1 to h[u + 1] do
    begin
			v:= a[i];
      if vs[v] then continue;

      if (d[v] > l[i]) then
      begin
				d[v]:= l[i];
        update(pos[v]);
      end;
    end;
  until FALSE;	
end;

procedure output;
var
	i: longint;
	res: int64;
begin
	res:= 0;
  for i:= 2 to n do
  	res:= res + d[i];

  writeln(fo,res);
end;


BEGIN
	openfile;
  input;
  init;
  build;
  prim;
  output;
  closefile;
END.
