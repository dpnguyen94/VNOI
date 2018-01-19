uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 1000 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n: longint;
  x,y,h,par: array[1..maxN] of longint;
  a: array[1..2 * maxN] of longint;

  vs,mark,inset: array[0..maxN] of boolean;
  res: longint;


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
	fillchar(h,sizeof(h),0);
	for i:= 1 to n - 1 do
  begin
  	readln(fi,u,v);

    inc(h[u]);
    inc(h[v]);

    x[i]:= u;
    y[i]:= v;
  end;

  for i:= 2 to n + 1 do
  	h[i]:= h[i - 1] + h[i];

  for i:= 1 to n - 1 do
  begin
  	u:= x[i];
    v:= y[i];

    a[h[u]]:= v;
    a[h[v]]:= u;

    dec(h[u]);
    dec(h[v]);
  end;
end;

procedure visit(u: longint);
var
	i,v: longint;
begin
	vs[u]:= true;

  for i:= h[u] + 1 to h[u + 1] do
  begin
  	v:= a[i];
    if vs[v] then continue;

    par[v]:= u;
    visit(v);
  end;

  if inset[u] then
  begin
  	inc(res);	
    mark[par[u]]:= true;
  end
  else
  	if not mark[u] then
    begin
    	if (u = 1) then inc(res)
			else inset[par[u]]:= true;
    end;
end;

procedure process;
begin
	if (n = 1) then
  begin
  	writeln(fo,1);
    exit;
  end;

  fillchar(vs,sizeof(vs),false);
  fillchar(inset,sizeof(inset),false);
  fillchar(mark,sizeof(mark),false);
  res:= 0;
  visit(1);

  writeln(fo,res);
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  while true do
  begin
  	readln(fi,n);
    if (n = 0) then break;
    input;
    process;
  end;
  closefile;
END.
