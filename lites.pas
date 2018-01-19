uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 100000 + 10;
  maxnode = 4 * maxN;
//type

var
	fi,fo: text;
  n,m,m1,t,s,e: longint;
  IT,c: array[1..maxnode] of longint;


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
	readln(fi,n,m);
end;

function getnum(nd,x,y,s,e: longint): longint;
var
	mid,num1,num2: longint;
begin
	if (s = x) and (e = y) then
  begin
		if (c[nd] mod 2 = 1) then exit(e - s + 1 - IT[nd])  	
    else exit(IT[nd]);
  end;

  num1:= 0;
  num2:= 0;
  mid:= (x + y) div 2;
  if (s <= mid) then num1:= getnum(2 * nd,x,mid,s,min(mid,e));
  if (mid + 1 <= e) then num2:= getnum(2 * nd + 1,mid + 1,y,max(mid + 1,s),e);

  if (c[nd] mod 2 = 1) then exit(e - s + 1 - num1 - num2)
  else exit(num1 + num2);
end;

procedure update(nd,x,y,s,e: longint);
var
	mid,num1,num2: longint;
begin
	if (s = x) and (e = y) then
  begin
  	inc(c[nd]);
    exit;
  end;

  mid:= (x + y) div 2;
  if (s <= mid) then update(2 * nd,x,mid,s,min(mid,e));
  if (mid + 1 <= e) then update(2 * nd + 1,mid + 1,y,max(mid + 1,s),e);

  if (c[2 * nd] mod 2 = 1) then num1:= mid - x + 1 - IT[2 * nd]
  else num1:= IT[2 * nd];
  if (c[2 * nd + 1] mod 2 = 1) then num2:= y - mid - IT[2 * nd + 1]
  else num2:= IT[2 * nd + 1];

  IT[nd]:= num1 + num2;
end;


BEGIN
	openfile;
  input;
  for m1:= 1 to m do
  begin
		read(fi,t);
    if (t = 0) then
    begin
    	readln(fi,s,e);
      update(1,1,n,s,e);
    end
    else
    begin
    	readln(fi,s,e);
      writeln(fo,getnum(1,1,n,s,e));
    end;
  end;
  closefile;
END.
