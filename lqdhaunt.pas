uses math;
const
  inputfile = '';
  outputfile = '';
  LM = 40;
  maxC = 1000000000;
type
	blackhole = record
    x,y,time: longint;
  end;
var
	fi,fo: text;
  w,h,g,e: longint;
  a,d: array[0..LM,0..LM] of longint;
  b: array[0..LM,0..LM] of blackhole;

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
	i,u1,v1,u2,v2,t: longint;
begin
  dec(w);
  dec(h);

  fillchar(a,sizeof(a),0);

  readln(fi,g);
  for i:= 1 to g do
  begin
  	readln(fi,u1,v1);
    a[u1,v1]:= 1;
  end;

  readln(fi,e);
  for i:= 1 to e do
  begin
  	readln(fi,u1,v1,u2,v2,t);

    a[u1,v1]:= 2;
    b[u1,v1].x:= u2;
    b[u1,v1].y:= v2;
    b[u1,v1].time:= t;
  end;
end;

procedure init;
var
	i,j: longint;
begin
	d[0,0]:= 0;

  for i:= 0 to w do
  	for j:= 0 to h do
    	if (i <> 0) or (j <> 0) then
      	d[i,j]:= maxC;
end;

procedure ford_bellman;
var
	loop,countloop: longint;
	i,j,u,v,k: longint;
  update: boolean;
begin
  countloop:= (w + 1) * (h + 1);
  for loop:= 1 to countloop do
  begin
  	for i:= 0 to w do
    	for j:= 0 to h do
     	begin
      	if (i = w) and (j = h) then continue;
        if (d[i,j] = maxC) then continue;

        if (a[i,j] = 0) then
        	for k:= 1 to 4 do
        	begin
						u:= i + dx[k];
          	v:= j + dy[k];

          	if (u < 0) or (u > w) or (v < 0) or (v > h) then continue;
          	if (a[u,v] = 1) then continue;

          	if (d[u,v] > d[i,j] + 1) then
            	d[u,v]:= d[i,j] + 1;
        	end;
			
      	if (a[i,j] = 2) then
        begin
        	u:= b[i,j].x;
          v:= b[i,j].y;

          if (a[u,v] = 1) then continue;

          if (d[u,v] > d[i,j] + b[i,j].time) then
          	d[u,v]:= d[i,j] + b[i,j].time;
        end;
      end;
  end;

  update:= false;
  countloop:= 1;
	for loop:= 1 to countloop do
  begin
  	for i:= 0 to w do
    	for j:= 0 to h do
     	begin
      	if (i = w) and (j = h) then continue;
				if (d[i,j] = maxC) then continue;

        if (a[i,j] = 0) then
        	for k:= 1 to 4 do
        	begin
						u:= i + dx[k];
          	v:= j + dy[k];

          	if (u < 0) or (u > w) or (v < 0) or (v > h) then continue;
          	if (a[u,v] = 1) then continue;

          	if (d[u,v] > d[i,j] + 1) then
            	if (d[u,v] <> 0) then update:= true;
        	end;
			
      	if (a[i,j] = 2) then
        begin
        	u:= b[i,j].x;
          v:= b[i,j].y;

          if (a[u,v] = 1) then continue;

          if (d[u,v] > d[i,j] + b[i,j].time) then
          	if (d[u,v] <> 0) then update:= true;
        end;
      end;
  end;

  if update then writeln(fo,'Never')
  else
  	if (d[w,h] = maxC) then writeln(fo,'Impossible')
    else writeln(fo,d[w,h]);
end;


BEGIN
	openfile;
  while TRUE do
  begin
  	readln(fi,w,h);
  	if (w = 0) and (h = 0) then break;
    input;
    init;
    ford_bellman;
  end;
  closefile;
END.
