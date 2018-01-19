uses math;
const
	inputfile = 'fruit.inp';
  outputfile = 'fruit.out';
  maxN = 1010;
//type

var
	fi,fo: text;
  n,m,k: longint;
  x,y,h,bs,f,d: array[1..maxN] of longint;
  vs: array[1..maxN] of boolean;
  a: array[1..2 * maxN] of longint;

  	
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
  for i:= 1 to n do
    read(fi,bs[i]);

  for i:= 1 to n-1 do
  begin
		readln(fi,x[i],y[i]);		
		inc(h[x[i]]);
    inc(h[y[i]]);
  end;

  for i:= 2 to n+1 do
  	h[i]:= h[i-1] + h[i];

  for i:= 1 to n-1 do
  begin
		u:= x[i];
    v:= y[i];

    a[h[u]]:= v;
    a[h[v]]:= u;

		dec(h[u]);
    dec(h[v]);
  end;
end;

procedure init;
var
	i,u,v,dq,cq: longint;

  procedure push(u: longint);
	begin
		inc(cq);
  	x[cq]:= u;
	end;

	function pop: longint;
	begin
		pop:= x[dq];
		inc(dq);
	end;

begin
	dq:= 1; cq:= 0;
  push(1);
  d[1]:= 1;

  while (dq <= cq) do
  begin
		u:= pop;

    for i:= h[u] + 1 to h[u+1] do
    begin
			v:= a[i];
      if (d[v] > 0) then continue;

      push(v);
      d[v]:= d[u] + 1;
    end;
  end;	
end;

function find(u: longint): longint;
var
	i,v: longint;
begin
	if vs[u] then exit;

	f[u]:= bs[u];
  vs[u]:= true;

  for i:= h[u] + 1 to h[u+1] do
  begin
		v:= a[i];
		if (d[v] < d[u]) then continue;

		find(v);
    f[u]:= f[u] + f[v];
    f[v]:= 0;
  end;
end;

procedure process;
var
	i,j,u,res: longint;
begin
	for i:= 1 to m do
  begin
  	fillchar(f,sizeof(f),0);
    fillchar(vs,sizeof(vs),false);
		read(fi,k);
    for j:= 1 to k do
    begin
			read(fi,u);
      find(u);
    end;

    //
    res:= 0;
    for j:= 1 to n do
    	res:= res + f[j];

    //
    writeln(fo,res);
  end;
end;

procedure output;
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
