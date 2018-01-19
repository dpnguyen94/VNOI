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
  test,ntest: longint;

  n,m,k,s,t: longint;
  x,y,z,l1: array[1..maxM] of longint;
  h: array[1..maxN] of longint;
  a,len: array[1..maxM] of longint;

  d: array[1..maxN] of longint;
  vs: array[1..maxN] of boolean;
  path: array[1..2,1..maxN] of longint;

  nheap: longint;
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
	i: longint;
begin
	readln(fi,n,m,k,s,t);
  for i:= 1 to m do
  	readln(fi,x[i],y[i],l1[i]);
end;

procedure build;
var
	i,u,v: longint;
begin
	fillchar(h,sizeof(h),0);
	for i:= 1 to m do
  begin
  	u:= x[i];
    inc(h[u]);
  end;

  for i:= 2 to n + 1 do
  	h[i]:= h[i-1] + h[i];

  for i:= 1 to m do
  begin
  	u:= x[i];
    v:= y[i];

    a[h[u]]:= v;
    len[h[u]]:= l1[i];

    dec(h[u]);
  end;
end;

procedure init(st: longint);
var
	i: longint;
begin
	d[st]:= 0;
  heap[1]:= st;
  pos[st]:= 1;
  nheap:= 1;

  for i:= 1 to n do
  	if (i <> st) then
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

procedure dijkstra(st: longint);
var
	i,u,v: longint;
begin
	init(st);

  repeat
		u:= pop;
    if (nheap = 0) then exit;
    vs[u]:= true;

    for i:= h[u] + 1 to h[u + 1] do
    begin
			v:= a[i];
      if vs[v] then continue;

      if (d[v] > d[u] + len[i]) then
      begin
      	d[v]:= d[u] + len[i];
        update(pos[v]);
      end;
    end;
  until FALSE;
end;

procedure process;
var
	i: longint;
begin
	for i:= 1 to 2 do
  	if (i = 1) then
    begin
    	build;
      dijkstra(s);
      path[1]:= d;
    end
    else
    begin
    	z:= x; x:= y; y:= z;
      build;
      dijkstra(t);
      path[2]:= d;
    end;
end;

procedure output;
var
	i,u,v,q: longint;
  res,sum: longint;
begin
	res:= path[1,t];

  for i:= 1 to k do
  begin
		readln(fi,u,v,q);
    sum:= min(path[1,u] + path[2,v], path[1,v] + path[2,u]) + q;

    res:= min(res,sum);
  end;

  if (res = maxC) then writeln(fo,-1)
  else writeln(fo,res);
end;


BEGIN
	openfile;
  readln(fi,ntest);
  for test:= 1 to ntest do
  begin
		input;
    process;
    output;
  end;
  closefile;
END.
