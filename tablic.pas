uses math;
const
	inputfile = '';
  outputfile = '';
  maxK = 1010;
type
	move = record
  	q,x,y: longint;
  end;
  position = record
  	x,y: longint;
  end;
var
	fi,fo: text;
  n,k: longint;
  a: array[1..maxK] of move;
  pos: array[1..maxK] of position;


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
	readln(fi,n,k);
  for i:= 1 to k do
  	with a[i] do
    	readln(fi,q,x,y);

  for i:= 1 to k do
  	if (a[i].q mod n = 0) then
    begin
    	pos[i].x:= a[i].q div n;
      pos[i].y:= n;
    end
    else
    begin
    	pos[i].x:= a[i].q div n + 1;
      pos[i].y:= a[i].q mod n;
    end;
end;

procedure process;
var
	i,j,r,c: longint;
begin
	for i:= 1 to k do
  begin
  	c:= a[i].y - pos[i].y;
    if (c < 0) then c:= c + n;
  	r:= a[i].x - pos[i].x;
    if (r < 0) then r:= r + n;

    writeln(fo,r + c);
  	
    for j:= i+1 to k do
    begin
    	if (pos[j].x = pos[i].x) then
      begin
				pos[j].y:= (pos[j].y + c) mod n;
        if (pos[j].y = 0) then pos[j].y:= n;
      end;
      if (pos[j].y = a[i].y) then
      begin
      	pos[j].x:= (pos[j].x + r) mod n;
        if (pos[j].x = 0) then pos[j].x:= n;
      end;									
    end;
  end;
end;

procedure output;
begin
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
