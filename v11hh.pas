uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 100 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n,x1,x2,y1,y2,res: longint;
  x,y,ttx,tty,a: array[1..maxN] of longint;


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
	readln(fi,n);
  for i:= 1 to n do
  begin
  	readln(fi,x[i],y[i]);
    ttx[i]:= i;
    tty[i]:= i;
  end;
end;

procedure solve;
var
	i,xmin,xmax,ymin,ymax: longint;	
begin	
	for i:= 1 to n do
  	if (a[ttx[i]] = 0) then
    begin
    	xmin:= x[i];
      break;
    end;
  for i:= n downto 1 do
  	if (a[ttx[i]] = 0) then
    begin
    	xmax:= x[i];
      break;
    end;

	for i:= 1 to n do
  	if (a[tty[i]] = 0) then
    begin
    	ymin:= y[i];
      break;
    end;
  for i:= n downto 1 do
  	if (a[tty[i]] = 0) then
    begin
    	ymax:= y[i];
      break;
    end;

  if (xmin = x1) and (xmax = x2)
  	and (ymin = y1) and (ymax = y2) then
    	inc(res);
end;

procedure attempt(i: longint);
var
	j: longint;
begin
	if (i > n) then
  begin
  	solve;
    exit;
  end;

  for j:= 0 to 1 do
  begin
		a[i]:= j;
    attempt(i + 1);
  end;
end;

procedure swap(var i,j: longint);
var
	temp: longint;
begin
	temp:= i;
  i:= j;
  j:= temp;
end;

procedure process;
var
	i,j: longint;
begin
  for i:= 1 to n - 1 do
  	for j:= i + 1 to n do
    	if (x[i] > x[j]) then
      begin
      	swap(x[i],x[j]);
        swap(ttx[i],ttx[j]);
      end;

  for i:= 1 to n - 1 do
  	for j:= i + 1 to n do
    	if (y[i] > y[j]) then
      begin
      	swap(y[i],y[j]);
        swap(tty[i],tty[j]);
      end;

  x1:= x[1]; x2:= x[n];
  y1:= y[1]; y2:= y[n];

  //
  res:= 0;
  attempt(1);

  writeln(fo,res - 1);
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
