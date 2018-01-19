{
ID: ndchiph1
PROG: apple
LANG: PASCAL
}
uses math;
const
	inputfile = 'apple.in';
  outputfile = 'apple.out';
  maxN = 100000 + 10;
  maxM = 200000 + 10;
  maxC = 2000000000 + 10;
//type

var
	fi,fo: text;
  n,m,s: longint;
  t: array[1..2] of longint;
  x,y,c1: array[1..maxM] of longint;
  h: array[1..maxN] of longint;
  a: array[1..2 * maxM] of longint;
  c: array[1..2 * maxM] of int64;

  d: array[1..maxN] of int64;
  path: array[1..2,1..maxN] of int64;
  vs: array[1..maxN] of boolean;
  heap,pos: array[1..maxN] of longint;
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
	i,u,v: longint;
begin
	readln(fi,m,n,s,t[1],t[2]);
  for i:= 1 to m do
  begin
  	readln(fi,u,v,c1[i]);
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
    c[h[u]]:= c1[i];
    c[h[v]]:= c1[i];

    dec(h[u]);
    dec(h[v]);
  end;
end;

procedure init(s: longint);
var
	i: longint;
begin
	d[s]:= 0;
  heap[1]:= s;
  pos[s]:= 1;
  nheap:= 1;

  for i:= 1 to n do
  	if (i <> s) then
    begin
			d[i]:= maxC;

      inc(nheap);
      heap[nheap]:= i;
      pos[i]:= nheap;
    end;	

  fillchar(vs,sizeof(vs),false);
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

procedure dijkstra;
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

      if (d[v] > d[u] + c[i]) then
      begin
      	d[v]:= d[u] + c[i];
        update(pos[v]);
      end;
    end;
  until false;
end;

procedure process;
var
	i: longint;
  path1,path2: int64;
begin
	for i:= 1 to 2 do
  begin
		init(t[i]);
    dijkstra;
    path[i]:= d;
  end;

  path1:= path[1,s] + path[1,t[2]];
  path2:= path[2,s] + path[2,t[1]];

  //
  if (path1 < path2) then writeln(fo,path1)
  else writeln(fo,path2);
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
