uses math;
const
	inputfile = 'genome.inp';
  outputfile = 'genome.out';
  LM = 1010;
//type

var
	fi,fo: text;
  n,m,q: longint;
  s,t,a,pos: array[1..LM] of longint;


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
	readln(fi,n,m);
  readln(fi,q);
  for i:= 1 to m do
  	readln(fi,s[i],t[i]);
  for i:= 1 to q do
  begin
  	readln(fi,a[i]);
    pos[i]:= a[i];
  end;
end;

procedure process;
var
	i,j: longint;
begin
	for i:= 1 to m do
  begin
		for j:= 1 to q do
    begin
    	if (pos[j] >= s[i]) and (pos[j] <= t[i]) then
      	pos[j]:= s[i] + t[i] - pos[j];
    end;
  end;
end;

procedure output;
var
	i: longint;
begin
	for i:= 1 to q do
  	writeln(fo,pos[i]);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
