uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 100000 + 10;
  maxnode = 5 * maxN;
type
	node = record
  	max1,max2: longint;
  end;
var
	fi,fo: text;
  ntest,test: longint;
  n,q,k: longint;
  IT: array[1..maxnode] of node;
  a: array[1..4] of longint;


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

procedure update(nd,x,y,pos: longint);
var
	mid,t: longint;
begin
	if (x = y) then
  begin
  	IT[nd].max1:= k;
    IT[nd].max2:= -maxlongint;
    exit;
  end;

  mid:= (x + y) div 2;
  if (pos <= mid) then update(2 * nd,x,mid,pos);
  if (pos >= mid + 1) then update(2 * nd + 1,mid + 1,y,pos);

  IT[nd].max1:= -maxlongint;
  IT[nd].max2:= -maxlongint;
  a[1]:= IT[2 * nd].max1;
  a[2]:= IT[2 * nd].max2;
  a[3]:= IT[2 * nd + 1].max1;
  a[4]:= IT[2 * nd + 1].max2;

  for t:= 1 to 4 do
  	if (a[t] > IT[nd].max1) then
    begin
    	IT[nd].max2:= IT[nd].max1;
    	IT[nd].max1:= a[t];
    end
    else
    	if (a[t] > IT[nd].max2) then
      	IT[nd].max2:= a[t];
end;

procedure input;
var
	i: longint;
begin
	readln(fi,n);
  for i:= 1 to n do
  begin
  	read(fi,k);
    update(1,1,n,i);
  end;
end;

procedure get(nd,x,y,u,v: longint; var i,j: longint);
var
	mid,t,i1,j1,i2,j2: longint;
begin
	if (u = x) and (v = y) then
  begin
  	i:= IT[nd].max1;
    j:= IT[nd].max2;
    exit;
  end;

  i:= -maxlongint;
  j:= -maxlongint;
  i1:= -maxlongint;
  j1:= -maxlongint;
  i2:= -maxlongint;
  j2:= -maxlongint;

  mid:= (x + y) div 2;
  if (u <= mid) then get(2 * nd,x,mid,u,min(v,mid),i1,j1);
  if (v >= mid + 1) then get(2 * nd + 1,mid + 1,y,max(u,mid + 1),v,i2,j2);

  a[1]:= i1; a[2]:= j1; a[3]:= i2; a[4]:= j2;
  for t:= 1 to 4 do
  	if (a[t] > i) then
    begin
    	j:= i;
      i:= a[t];
    end
    else
    	if (a[t] > j) then
      	j:= a[t];
end;

procedure process;
var
	i,pos,u,v,res1,res2: longint;
  ch: char;
begin
  readln(fi,q);
  for i:= 1 to q do
  begin
  	read(fi,ch);
    if (ch = 'Q') then
    begin
    	readln(fi,u,v);
			get(1,1,n,u,v,res1,res2);
      writeln(fo,res1 + res2);
    end
    else
	  begin
    	readln(fi,pos,k);
      update(1,1,n,pos);
    end;
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
