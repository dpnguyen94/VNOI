uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 50000 + 10;
  maxnode = 4 * maxN;
//type

var
	fi,fo: text;
  n,m,t,tt,u,v,k: longint;
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

function getmax(nd,x,y,u,v: longint): longint;
var
	mid,max1,max2: longint;
begin
	if (x = u) and (y = v) then exit(IT[nd] + c[nd]);

  max1:= -maxlongint;
  max2:= -maxlongint;
  mid:= (x + y) div 2;
  if (u <= mid) then max1:= getmax(2 * nd,x,mid,u,min(v,mid));
  if (mid + 1 <= v) then max2:= getmax(2 * nd + 1,mid + 1,y,max(u,mid + 1),v);

  exit(max(max1,max2) + c[nd]);
end;

procedure update(nd,x,y,u,v: longint);
var
	mid: longint;
begin
	if (x = u) and (y = v) then
  begin
  	inc(c[nd],k);
    exit;
  end;

  mid:= (x + y) div 2;
  if (u <= mid) then update(2 * nd,x,mid,u,min(v,mid));
  if (mid + 1 <= v) then update(2 * nd + 1,mid + 1,y,max(u,mid + 1),v);
  	
  IT[nd]:= max(IT[2 * nd] + c[2 * nd], IT[2 * nd + 1] + c[2 * nd + 1]);
end;


BEGIN
	openfile;
  readln(fi,n,m);
  for t:= 1 to m do
  begin
  	read(fi,tt);
    if (tt = 0) then
    begin
    	readln(fi,u,v,k);
      update(1,1,n,u,v);
    end
    else
    begin
    	readln(fi,u,v);
      writeln(fo,getmax(1,1,n,u,v));
    end;
  end;
  closefile;
END.
