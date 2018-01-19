uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 50000 + 10;
  maxnode = 4 * maxN;
  inf = 10000 + 10;
type
	node = record
		left,right,sum,gss: longint;
  end;
var
	fi,fo: text;
  ntest,test: longint;
  n,m,q,k: longint;
  a: array[1..maxN] of longint;
  IT: array[1..maxnode] of node;


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
	mid: longint;
begin
	if (x = y) then
  begin
  	with IT[nd] do
    begin
    	left:= k;
      right:= k;
      sum:= k;
      gss:= k;
    end;
    exit;
  end;
	
  mid:= (x + y) div 2;
	if (pos <= mid) then update(2 * nd,x,mid,pos);
  if (pos >= mid + 1) then update(2 * nd + 1,mid + 1,y,pos);

  with IT[nd] do
  begin
  	left:= max(IT[2 * nd].left,IT[2 * nd].sum + IT[2 * nd + 1].left);
    right:= max(IT[2 * nd + 1].right,IT[2 * nd + 1].sum + IT[2 * nd].right);
    sum:= IT[2 * nd].sum + IT[2 * nd + 1].sum;
    gss:= max(max(IT[2 * nd].gss,IT[2 * nd + 1].gss),IT[2 * nd].right + IT[2 * nd + 1].left);
  end;
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

procedure get(nd,x,y,u,v: longint; var le,ri,s,g: longint);
var
	mid,le1,ri1,s1,g1,le2,ri2,s2,g2: longint;
begin
	if (u = x) and (v = y) then
  begin
		with IT[nd] do
    begin
    	le:= left;
      ri:= right;
      s:= sum;
      g:= gss;
    end;
    exit;
  end;

  le1:= -inf; ri1:= -inf; s1:= 0; g1:= -inf;
  le2:= -inf; ri2:= -inf; s2:= 0; g2:= -inf;

  mid:= (x + y) div 2;
  if (u <= mid) then get(2 * nd,x,mid,u,min(v,mid),le1,ri1,s1,g1);
  if (v >= mid + 1) then get(2 * nd + 1,mid + 1,y,max(u,mid + 1),v,le2,ri2,s2,g2);	

  le:= max(le1,s1 + le2);
  ri:= max(ri2,s2 + ri1);
  s:= s1 + s2;
  g:= max(max(g1,g2),ri1 + le2);
end;

procedure process;
var
	i,num,u,v,le,ri,s,g: longint;
begin
	readln(fi,q);
  for i:= 1 to q do
  begin
  	readln(fi,num,u,v);

    //
    if (num = 0) then
    begin
    	k:= v;
    	update(1,1,n,u);
  	end
    else
    begin
    	get(1,1,n,u,v,le,ri,s,g);
      writeln(fo,g);
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
