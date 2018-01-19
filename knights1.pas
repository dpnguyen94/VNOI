uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 3000 + 10;
  maxM = 100000 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n,m,q,s,t: longint;
  x,y,c: array[1..maxM] of longint;
  lab: array[1..maxN] of longint;


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
	readln(fi,n,m);
  for i:= 1 to m do
  	readln(fi,x[i],y[i],c[i]);
end;

procedure swap(var i,j: longint);
var
	z: longint;
begin
	z:= i;
  i:= j;
  j:= z;
end;

procedure sort(le,ri: longint);
var
	i,j,t: longint;
begin
	if (le >= ri) then exit;
  i:= le; j:= ri;
  t:= c[(le + ri) div 2];

  repeat
  	while (c[i] < t) do inc(i);
    while (c[j] > t) do dec(j);

    if (i <= j) then
    begin
			swap(c[i],c[j]);
      swap(x[i],x[j]);
      swap(y[i],y[j]);

      inc(i);
      dec(j);
    end;
  until i > j;

  sort(le,j);
  sort(i,ri);
end;

function getroot(i: longint): longint;
begin
	while (lab[i] > 0) do i:= lab[i];
	getroot:= i;
end;

procedure union(r1,r2: longint);
var
	sum: longint;
begin
	sum:= lab[r1] + lab[r2];
  if (lab[r1] > lab[r2]) then
  begin
		lab[r1]:= r2;
    lab[r2]:= sum;
  end
  else
  begin
  	lab[r2]:= r1;
    lab[r1]:= sum;
  end;
end;

procedure solve;
var
	i,u,v,r1,r2: longint;
begin
	for i:= 1 to n do
  	lab[i]:= -1;

	for i:= 1 to m do
  begin
  	u:= x[i];
    v:= y[i];

    r1:= getroot(u);
    r2:= getroot(v);

    if (r1 = r2) then continue;

		union(r1,r2);

    if (getroot(s) = getroot(t)) then
    begin
    	writeln(fo,c[i]);
      exit;
    end;
  end;
end;

procedure process;
var
	i: longint;
begin
	sort(1,m);

  //
	readln(fi,q);
  for i:= 1 to q do
  begin
  	readln(fi,s,t);
		solve;
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
