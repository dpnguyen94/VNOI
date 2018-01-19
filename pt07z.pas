uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 10000 + 10;
//type

var
	fi,fo: text;
  n,res: longint;
  x,y,h,f: array[1..maxN] of longint;
  a: array[1..2 * maxN] of longint;
  vs: array[1..maxN] of boolean;


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
	readln(fi,n);
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
	i,v,max1,max2: longint;
begin
	vs[u]:= true;

  max1:= 0;
  max2:= 0;
  for i:= h[u] + 1 to h[u + 1] do
  begin
  	v:= a[i];
    if vs[v] then continue;

    visit(v);
		if (f[v] + 1 > max1) then
    begin
    	max2:= max1;
      max1:= f[v] + 1;
    end
    else
    	if (f[v] + 1 > max2) then
      	max2:= f[v] + 1;
  end;

	f[u]:= max1;
  res:= max(res,max1 + max2);
end;

procedure process;
begin
	fillchar(vs,sizeof(vs),false);
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
  input;
  process;
  output;
  closefile;
END.
