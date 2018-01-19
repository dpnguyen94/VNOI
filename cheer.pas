uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 10000 + 10;
  maxM = 100000 + 10;
  maxC = 1000000000;
//type

var
	fi,fo: text;
  n,m,nheap,cmin: longint;
  c: array[1..maxN] of longint;
  x,y,l1: array[1..maxM] of longint;
  h: array[1..maxN] of longint;
  a,l: array[1..2 * maxM] of longint;

  d: array[1..maxN] of longint;
  vs: array[1..maxN] of boolean;
  heap,pos: array[1..maxN] of longint;


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
	i,u,v,temp: longint;
begin
	readln(fi,n,m);
  cmin:= maxlongint;
	for i:= 1 to n do
  begin
  	readln(fi,c[i]);
    cmin:= min(cmin,c[i]);
  end;

  for i:= 1 to m do
  begin
  	readln(fi,u,v,l1[i]);
    inc(h[u]);
    inc(h[v]);

    x[i]:= u;
    y[i]:= v;
  end;

  for i:= 2 to n + 1 do
  	h[i]:= h[i - 1] + h[i];

  for i:= 1 to m do
  begin
  	u:= x[i];
    v:= y[i];

    a[h[u]]:= v;
    a[h[v]]:= u;

    temp:= 2 * l1[i] + c[u] + c[v];
    l[h[u]]:= temp;
    l[h[v]]:= temp;

    dec(h[u]);
    dec(h[v]);
  end;
end;

procedure init;
var
	i: longint;
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
    if (c < nheap) and (d[heap[c]] > d[heap[c + 1]]) then inc(c);
    if (c > nheap) or (d[i] <= d[heap[c]]) then break;

    heap[p]:= heap[c];
    pos[heap[p]]:= p;
    p:= c;
  until false;

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
  until false;

  heap[c]:= i;
  pos[i]:= c;
end;

procedure prim;
var
	i,u,v: longint;
begin
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
  until false;
end;

procedure output;
var
	i,res: longint;
begin
	res:= 0;
  for i:= 2 to n do
  	res:= res + d[i];

  writeln(fo,res + cmin);
end;


BEGIN
	openfile;
  input;
  init;
  prim;
  output;
  closefile;
END.
