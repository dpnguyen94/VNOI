uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 20 + 1;
//type

var
	fi,fo: text;
  n,m,x,y: longint;
  p,f: array[0..LM,0..LM] of longint;


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
	readln(fi,n,m);
  readln(fi,x,y);
  for i:= 1 to n do
  	for j:= 1 to m do
    	read(fi,p[i,j]);
end;

procedure process;
var
	i,j: longint;
begin
	for i:= 0 to LM do
  	for j:= 0 to LM do
    	f[i,j]:= maxlongint;

  f[x,y]:= 0;
  for i:= y + 1 to m do
  	f[x,i]:= f[x,i - 1] + p[x,i];

  for i:= x + 1 to n do
  	for j:= y to m do
    	f[i,j]:= min(f[i - 1,j], f[i,j - 1]) + p[i,j];
end;

procedure output;
var
	res: longint;
begin
	res:= p[x,y] - f[n,m];
  if (res >= 0) then writeln(fo,'Y ',res)
  else writeln(fo,'N');
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
