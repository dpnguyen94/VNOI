uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 500 + 10;
type
	point = record
  	x,y: longint;
  end;
var
	fi,fo: text;
  n,m,mid,res: longint;
  d: array[0..LM,0..LM] of longint;
  vs: array[0..LM,0..LM] of boolean;

  qu: array[1..LM * LM] of point;
  dq,cq: longint;
  s,t: point;

  dx: array[1..4] of longint = (0,0,1,-1);
  dy: array[1..4] of longint = (1,-1,0,0);


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

procedure push(u,v: longint);
begin
	inc(cq);
  qu[cq].x:= u;
  qu[cq].y:= v;
end;

procedure pop(var u,v: longint);
begin
	u:= qu[dq].x;
  v:= qu[dq].y;
  inc(dq);
end;

procedure input;
var
	i,j: longint;
  c: char;
begin
	readln(fi,n,m);

  dq:= 1;
  cq:= 0;
  for i:= 1 to n do
  begin
  	for j:= 1 to m do
    begin
    	read(fi,c);
    	if (c = '+') then
      begin
        push(i,j);
        vs[i,j]:= true;
      end;
      if (c = 'V') then
      begin
      	s.x:= i;
        s.y:= j;
      end;
      if (c = 'J') then
      begin
      	t.x:= i;
        t.y:= j;
      end;
    end;
    readln(fi);
  end;
end;

procedure init;
var
	u,v,i,j,k: longint;
begin
	while (dq <= cq) do
  begin
  	pop(u,v);

		for k:= 1 to 4 do
    begin
    	i:= u + dx[k];
      j:= v + dy[k];

      if (i < 1) or (i > n) or (j < 1) or (j > m) then continue;
      if vs[i,j] then continue;

      push(i,j);
      d[i,j]:= d[u,v] + 1;
      vs[i,j]:= true;
    end;
  end;
end;

procedure go(u,v: longint);
var
	i,j,k: longint;
begin
	if (d[u,v] < mid) then exit;
	vs[u,v]:= true;

  for k:= 1 to 4 do
  begin
		i:= u + dx[k];
    j:= v + dy[k];

    if (i < 1) or (i > n) or (j < 1) or (j > m) then continue;
    if vs[i,j] then continue;

    go(i,j);
  end;
end;

procedure process;
var
	le,ri: longint;
begin
	le:= 0; ri:= n * m;
  while (le <= ri) do
  begin
  	mid:= (le + ri) div 2;
    fillchar(vs,sizeof(vs),false);
    go(s.x,s.y);
    if vs[t.x,t.y] then
    begin
    	res:= mid;
    	le:= mid + 1
    end
    else ri:= mid - 1;
  end;
end;

procedure output;
begin
	writeln(fo,res);
end;


BEGIN
	openfile;
  input;
  init;
  process;
  output;
  closefile;
END.
