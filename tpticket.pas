uses math;
const
  maxN = 100005;
//type
var
  n,k,m: longint;
  IT,c: array[0..4 * maxN] of longint;


procedure openfile;
begin
  assign(input,''); reset(input);
  assign(output,''); rewrite(output);
end;

procedure closefile;
begin
	close(input);
  close(output);
end;

procedure input;
begin
  readln(n,k,m);
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
  	inc(c[nd]);
    exit;
  end;

  mid:= (x + y) div 2;
  if (u <= mid) then update(2 * nd,x,mid,u,min(v,mid));
  if (mid + 1 <= v) then update(2 * nd + 1,mid + 1,y,max(u,mid + 1),v);

  IT[nd]:= max(IT[2 * nd] + c[2 * nd], IT[2 * nd + 1] + c[2 * nd + 1]);
end;

procedure process;
var
  i,x,y,num: longint;
begin
  for i:= 1 to m do
  begin
    readln(x,y);
    inc(x);
    inc(y);

    num:= getmax(1,1,n,x,y - 1);
    if (num < k) then
    begin
      writeln(1);
      update(1,1,n,x,y - 1);
    end
    else writeln(0);
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
