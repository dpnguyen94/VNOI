uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 1000 + 10;
//type

var
	fi,fo: text;
  n,m: longint;
  a: array[1..maxN,1..maxN] of longint;
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
  c: char;
begin
	readln(fi,n);
  readln(fi,m);
	for i:= 1 to m do
  begin
  	read(fi,c,u,v);
    if (c = 'F') then
    begin
    	a[u,v]:= 1;
      a[v,u]:= 1;
    end;
    if (c = 'E') then
    begin
    	a[u,v]:= 2;
      a[v,u]:= 2;
    end;
    readln(fi);
  end;
end;

procedure visit1(u: longint); forward;

procedure visit2(u: longint);
var
	v: longint;
begin
	for v:= 1 to n do
  	if not vs[v] and (a[u,v] = 2) then
			visit1(v);
end;

procedure visit1(u: longint);
var
	v: longint;
begin
	vs[u]:= true;

	for v:= 1 to n do
  begin
		if not vs[v] and (a[u,v] = 1) then visit1(v);
    if (a[u,v] = 2) then visit2(v);
  end;
end;

procedure process;
var
	i,cnt: longint;
begin
	cnt:= 0;
	for i:= 1 to n do
  	if not vs[i] then
    begin
			inc(cnt);
      visit1(i);
    end;

  writeln(fo,cnt);
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
