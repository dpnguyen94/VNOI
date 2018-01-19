uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 200 + 10;
type
	queue = record
  	x,y: longint;
  end;
var
	fi,fo: text;
  ntest,test: longint;
  n,m: longint;
  a,d: array[0..LM,0..LM] of longint;

  qu: array[1..LM * LM] of queue;
  dq,cq: longint;

  dx: array[1..4] of longint = (0,0,-1,1);
  dy: array[1..4] of longint = (-1,1,0,0);


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
  ch: char;
begin
	readln(fi,n,m);
  for i:= 1 to n do
  begin
		for j:= 1 to m do
    begin
    	read(fi,ch);
      a[i,j]:= ord(ch) - ord('0');
    end;
		readln(fi);
  end;
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

procedure init;
var
	i,j: longint;
begin
	fillchar(d,sizeof(d),0);
  dq:= 1;
  cq:= 0;

	for i:= 1 to n do
  	for j:= 1 to m do
    	if (a[i,j] = 1) then
      begin
      	push(i,j);
        d[i,j]:= 1;
      end;
end;

procedure process;
var
	u,v,u1,v1,k: longint;
begin
	while (dq <= cq) do
  begin
		pop(u,v);

    for k:= 1 to 4 do
    begin
			u1:= u + dx[k];
      v1:= v + dy[k];

      if (u1 < 1) or (u1 > n) or (v1 < 1) or (v1 > m) then continue;
      if (d[u1,v1] > 0) then continue;

      push(u1,v1);
      d[u1,v1]:= d[u,v] + 1;
    end;
  end;
end;

procedure output;
var
	i,j: longint;
begin
	for i:= 1 to n do
  begin
  	for j:= 1 to m do
    	write(fo,d[i,j] - 1,' ');
    writeln(fo);
  end;
end;


BEGIN
	openfile;
  readln(fi,ntest);
  for test:= 1 to ntest do
  begin
  	input;
    init;
    process;
    output;
  end;
  closefile;
END.
