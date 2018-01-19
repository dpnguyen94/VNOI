uses math;
const
	inputfile = 'erp.inp';
  outputfile = 'erp.out';
  LM = 100 + 10;
  maxC = 1000000000;
type
	point = record
  	x,y,z: longint;
  end;	
var
	fi,fo: text;
  m,n: longint;
  s,f: point;
  a: array[0..LM,0..LM] of char;
  d: array[0..LM,0..LM,0..3] of longint;

  h: array[1..3 * LM * LM] of point;
  pos: array[0..LM,0..LM,0..3] of longint;
  nh: longint;

  dx: array[0..3] of longint = (0,-1,0,1);
  dy: array[0..3] of longint = (-1,0,1,0);
  add: array[0..3] of longint = (0,5,10,1);


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
	readln(fi,m,n);
  for i:= 1 to m do
  begin
  	for j:= 1 to n do
    begin
    	read(fi,a[i,j]);

    	if (a[i,j] = 'S') or (a[i,j] = 'N')
    		or (a[i,j] = 'E') or (a[i,j] = 'W') then
      	begin
      		s.x:= i;
        	s.y:= j;

        	case a[i,j] of
						'S': s.z:= 3;
          	'N': s.z:= 1;
          	'E': s.z:= 2;
          	'W': s.z:= 0;
        	end;
      	end;

    		if (a[i,j] = 'F') then
      	begin
      		f.x:= i;
        	f.y:= j;
      	end;
    end;

    readln(fi);
  end;
end;

procedure init;
var
	i,j,k: longint;
begin
	d[s.x,s.y,s.z]:= 0;
  h[1].x:= s.x;
  h[1].y:= s.y;
  h[1].z:= s.z;
  pos[s.x,s.y,s.z]:= 1;
  nh:= 1;

	for i:= 1 to m do
   	for j:= 1 to n do
    begin
    	if (a[i,j] = '.') then continue;

      for k:= 0 to 3 do
      	if (i <> s.x) or (j <> s.y) or (k <> s.z) then
        begin
        	d[i,j,k]:= maxC;

        	inc(nh);
          h[nh].x:= i;
          h[nh].y:= j;
          h[nh].z:= k;
          pos[i,j,k]:= nh;
        end;
    end;
end;

procedure pop(var u,v,k: longint);
var
	i,j,t,p,c: longint;
begin
	u:= h[1].x;
  v:= h[1].y;
  k:= h[1].z;

  i:= h[nh].x;
  j:= h[nh].y;
  t:= h[nh].z;
  dec(nh);

  p:= 1;
  repeat
  	c:= p * 2;	
		if (c < nh) and (d[h[c].x,h[c].y,h[c].z] > d[h[c+1].x,h[c+1].y,h[c+1].z]) then inc(c);  	
    if (c > nh) or (d[i,j,t] <= d[h[c].x,h[c].y,h[c].z]) then break;

    h[p]:= h[c];
    pos[h[p].x,h[p].y,h[p].z]:= p;
    p:= c;
  until false;

  h[p].x:= i;
  h[p].y:= j;
  h[p].z:= t;
  pos[i,j,t]:= p;
end;

procedure update(ps: longint);
var
	i,j,t,c,p: longint;
begin
	i:= h[ps].x;
  j:= h[ps].y;
  t:= h[ps].z;

  c:= ps;
  repeat
  	p:= c div 2;
    if (p = 0) or (d[i,j,t] >= d[h[p].x,h[p].y,h[p].z]) then break;

    h[c]:= h[p];
    pos[h[c].x,h[c].y,h[c].z]:= c;
    c:= p;
  until false;

  h[c].x:= i;
  h[c].y:= j;
  h[c].z:= t;
  pos[i,j,t]:= c;
end;

procedure dijkstra;
var
	i,j,t,i1,j1,t1,k: longint;
begin
	repeat
  	pop(i,j,t);
    if (nh = 0) then exit;

    i1:= i + dx[t];
    j1:= j + dy[t];

    if (i1 < 1) or (i1 > m) or (j1 < 1) or (j1 > n) then continue;
    if (a[i1,j1] = '.') then continue;

    for k:= 0 to 3 do
    begin
    	t1:= (t + k) mod 4;
      if (d[i1,j1,t1] > d[i,j,t] + add[k]) then
      begin
				d[i1,j1,t1]:= d[i,j,t] + add[k];
        update(pos[i1,j1,t1]);
      end;
    end;
  until false;
end;

procedure output;
var
	k,res: longint;
begin
	res:= maxC;
	for k:= 0 to 3 do
  	if (d[f.x,f.y,k] < res) then
    	res:= d[f.x,f.y,k];

  writeln(fo,res);
end;


BEGIN
	openfile;
  input;
  init;
  dijkstra;
  output;
  closefile;
END.
