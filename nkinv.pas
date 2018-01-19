uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 60000 + 10;
  maxnode = 4 * maxN;
//type

var
	fi,fo: text;
  n,res: longint;
	a: array[1..maxN] of longint;
  IT: array[1..maxnode] of longint;


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
  	readln(fi,a[i]);
end;

function getnum(nd,x,y,u,v: longint): longint;
var
	mid,num1,num2: longint;
begin
	if (v < u) then exit(0);
  if (x = u) and (y = v) then exit(IT[nd]);

  num1:= 0;
  num2:= 0;
  mid:= (x + y) div 2;
  if (u <= mid) then num1:= getnum(2 * nd,x,mid,u,min(mid,v));
  if (mid + 1 <= v) then num2:= getnum(2 * nd + 1,mid + 1,y,max(u,mid + 1),v);

  exit(num1 + num2);
end;

procedure update(nd,x,y,val,k: longint);
var
	mid: longint;
begin
	if (x = y) then
  begin
  	inc(IT[nd],k);
    exit;
  end;

  mid:= (x + y) div 2;
  if (val <= mid) then update(2 * nd,x,mid,val,k);
  if (mid + 1 <= val) then update(2 * nd + 1,mid + 1,y,val,k);
  IT[nd]:= IT[2 * nd] + IT[2 * nd + 1];
end;

procedure process;
var
	i: longint;
begin
	res:= 0;

	update(1,1,maxN,a[1],1);
	for i:= 2 to n do
  begin
		inc(res,getnum(1,1,maxN,a[i] + 1,maxN));  	
    update(1,1,maxN,a[i],1);
  end;
end;

procedure output;
begin
	writeln(fo,res);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
