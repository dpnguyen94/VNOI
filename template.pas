uses math;
var
	IT,c: array[1..200000] of longint;
  k: longint;

procedure update(nd,x,y,u,v: longint);
var
	mid: longint;
begin
	if (u = x) and (v = y) then
  begin
  	inc(c[nd],k);
    exit;
  end;

  mid:= (x + y) div 2;
  if (u <= mid) then update(2 * nd,x,mid,u,min(v,mid));
  if (v >= mid + 1) then update(2 * nd + 1,mid + 1,y,max(u,mid + 1),v);
	IT[nd]:= min(IT[2 * nd] + c[2 * nd],IT[2 * nd + 1] + c[2 * nd] + 1);
end;

function getmin(nd,x,y,u,v: longint): longint;
var
	mid,min1,min2: longint;
begin
	if (u = x) and (v = y) then exit(IT[nd]);

  min1:= -maxlongint;
  min2:= -maxlongint;
  mid:= (x + y) div 2;
  if (u <= mid) then min1:= getmin(2 * nd,x,mid,u,min(v,mid));
  if (v >= mid + 1) then min2:= getmin(2 * nd + 1,mid + 1,y,max(u,mid + 1),v);

  exit(max(min1,min2) + c[nd]);
end;

BEGIN
END.