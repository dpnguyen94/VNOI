uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 250 + 10;
  maxM = maxN * maxN;
type
	queue = record
  	t,x,y: longint;
  end;
var
	fi,fo: text;
  ntest,test: longint;
  n,m,s,t: longint;
  x,y,a: array[1..maxM] of longint;
  h: array[1..maxN] of longint;

  d: array[1..2,1..maxN,1..maxN] of longint;
  vs: array[1..2,1..maxN,1..maxN] of boolean;
  qu: array[1..2 * maxN * maxN] of queue;
  dq,cq: longint;


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
	readln(fi,n,m);
  readln(fi,s,t);
	for i:= 1 to m do
  begin
  	readln(fi,u,v);
    inc(h[u]);

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

    dec(h[u]);
  end;
end;

procedure push(k,u,v: longint);
begin
	inc(cq);
  qu[cq].t:= k;
  qu[cq].x:= u;
  qu[cq].y:= v;
end;

procedure pop(var k,u,v: longint);
begin
	k:= qu[dq].t;
  u:= qu[dq].x;
  v:= qu[dq].y;
  inc(dq);
end;

procedure process;
var
	i,next,k,u,v: longint;
begin
	dq:= 1; cq:= 0;
	push(1,s,t);
  vs[1,s,t]:= true;

  while (dq <= cq) do
  begin
  	pop(k,u,v);

    //
    if (k = 1) then
    	for i:= h[u] + 1 to h[u + 1] do
      begin
				next:= a[i];
        if vs[2,next,v] then continue;

        push(2,next,v);
        vs[2,next,v]:= true;
        d[2,next,v]:= d[k,u,v] + 1;
      end
    else
      for i:= h[v] + 1 to h[v + 1] do
      begin
				next:= a[i];
        if vs[1,u,next] then continue;

        push(1,u,next);
        vs[1,u,next]:= true;
        d[1,u,next]:= d[k,u,v] + 1;
      end;
  end;
end;

procedure output;
var
	i,res: longint;
begin
	res:= maxlongint;
	for i:= 1 to n do
  	if vs[1,i,i] and (d[1,i,i] < res) then res:= d[1,i,i];

  if (res = maxlongint) then writeln(fo,-1)
  else writeln(fo,res div 2);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
