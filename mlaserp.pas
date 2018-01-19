uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 110;
type
	queue = record
  	x,y: longint;
	end;
var
	fi,fo: text;
  w,h,dq,cq: longint;
  a: array[0..LM,0..LM] of boolean;
  d: array[0..LM,0..LM] of longint;
  xn,yn: array[1..2] of longint;

  qu: array[1..LM * LM] of queue;
  dx: array[1..4] of longint = (0,0,-1,1);
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

procedure input;
var
	i,j,cnt: longint;
  c: char;
begin
	readln(fi,w,h);
  cnt:= 0;
  for i:= 1 to h do
  begin
  	for j:= 1 to w do
    begin
    	read(fi,c);
    	if (c = '*') then a[i,j]:= true;
    	if (c = 'C') then
   	 	begin
    		inc(cnt);
      	xn[cnt]:= i;
      	yn[cnt]:= j;
    	end;
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

procedure process;
var
	u,v,u1,v1,k,kk: longint;
begin	
	dq:= 1;
  cq:= 0;
  push(xn[1],yn[1]);
  d[xn[1],yn[1]]:= 1;

  while (dq <= cq) do
	begin
  	pop(u,v);

    for k:= 1 to 4 do
    	for kk:= 1 to 100 do
      begin
				u1:= u + kk * dx[k];
        v1:= v + kk * dy[k];

        if (u1 < 1) or (u1 > h) or (v1 < 1) or (v1 > w) or a[u1,v1] then break;
		    if (d[u1,v1] > 0) then continue;

        push(u1,v1);
        d[u1,v1]:= d[u,v] + 1;
      end;
  end;
end;

procedure output;
begin
	writeln(fo,d[xn[2],yn[2]] - 2);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
