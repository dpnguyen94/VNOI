uses math;
const
	inputfile = 'multq3.inp';
  outputfile = 'multq3.out';
  maxN = 100000 + 10;
  maxnode = 5 * maxN;
type
	node = record
  	m0,m1,m2: longint;
  end;                        	
var
	fi,fo: text;
  n,q: longint;
  IT: array[1..maxnode] of node;
  c: array[1..maxnode] of longint;


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
begin
	readln(fi,n,q);
end;

procedure init(nd,x,y: longint);
var
	mid: longint;
begin
	if (x = y) then
  begin
  	IT[nd].m0:= 1;
    exit;
  end;

  mid:= (x + y) div 2;
  init(2 * nd,x,mid);
  init(2 * nd + 1,mid + 1,y);

  IT[nd].m0:= IT[2 * nd].m0 + IT[2 * nd + 1].m0;
end;

procedure update(nd,x,y,u,v: longint);
var
	mid,num1,num2: longint;
begin
	if (u = x) and (v = y) then
  begin
  	inc(c[nd]);
    exit;
  end;

  mid:= (x + y) div 2;
  if (u <= mid) then update(2 * nd,x,mid,u,min(v,mid));
  if (v >= mid + 1) then update(2 * nd + 1,mid + 1,y,max(u,mid + 1),v);



end;

procedure process;
var
	i,u,v,num: longint;
begin
	init(1,1,n);

	for i:= 1 to q do
  begin
		readln(fi,num,u,v);
    inc(u);
    inc(v);

    if (num = 0) then update(1,1,n,u,v)
    else writeln(fo,get(1,1,n,u,v));
  end;
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
