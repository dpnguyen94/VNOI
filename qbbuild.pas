uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 100 + 10;
  maxC = 1000000000;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n,res: longint;
  c: array[1..maxN,1..maxN] of longint;
  a,x: array[1..4] of longint;
  vs: array[1..4] of boolean;


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
	i,u,v,k: longint;
begin
	readln(fi,n);
  for u:= 1 to n do
  	for v:= 1 to n do
    	if (u <> v) then c[u,v]:= maxC;

  for i:= 1 to 4 do
  	read(fi,a[i]);

  while not eof(fi) do
  begin
  	readln(fi,u,v,k);
    c[u,v]:= k;
    c[v,u]:= k;
  end;
end;

procedure solve;
var
	s,t,temp: longint;
begin
	for s:= 1 to n do
  	for t:= 1 to n do
    begin
			temp:= c[s,t] + c[a[x[1]],s] + c[a[x[2]],s]
      			+ c[a[x[3]],t] + c[a[x[4]],t];
    	res:= min(res,temp);
    end;
end;

procedure attempt(i: longint);
var
	j: longint;
begin
  if (i > 4) then
  begin
  	solve;
  	exit;
  end;

  for j:= 1 to 4 do
  	if not vs[j] then
    begin
			x[i]:= j;
      vs[j]:= true;
      attempt(i + 1);
      vs[j]:= false;
    end;
end;

procedure process;
var
	u,v,k: longint;
begin
	for k:= 1 to n do
  	for u:= 1 to n do
    	for v:= 1 to n do
      	if (c[u,v] > c[u,k] + c[k,v]) then
        	c[u,v]:= c[u,k] + c[k,v];

	res:= maxC;
  attempt(1);
end;

procedure output;
begin
	writeln(fo,res);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
