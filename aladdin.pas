uses math;
const
	inputfile = 'aladdin.inp';
  outputfile = 'aladdin.out';
  maxN = 200 + 10;
//type

var
	fi,fo: text;
  n: longint;
  a,b,c: array[0..maxN,0..maxN] of longint;
  dx: array[1..4] of longint = (-1,-1,0,0);
  dy: array[1..4] of longint = (-1,0,-1,0);


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
	i,j: longint;
begin
	readln(fi,n);
  for i:= 1 to n - 1 do
  	for j:= 1 to n - 1 do
    	read(fi,b[i,j]);
end;

procedure printres;
var
	i,j: longint;
begin
	for i:= 1 to n do
  begin
  	for j:= 1 to n do
    	write(fo,a[i,j],' ');
    writeln(fo);
  end;
end;

function isvalid(i,j: longint): boolean;
var
	t,u,v: longint;
begin
	for t:= 1 to 4 do
  begin
  	u:= i + dx[t];
    v:= j + dy[t];

    if (u < 1) or (v < 1)
    	or (u > n - 1) or (v > n - 1) then continue;

    if (t = 1) then
    begin
    	if (c[u,v] <> b[u,v]) then exit(false);
    end
    else
    	if (c[u,v] > b[u,v]) then exit(false);
  end;

  exit(true);
end;

procedure setc(i,j,k: longint);
var
	t,u,v: longint;
begin
    for t:= 1 to 4 do
    begin
    	u:= i + dx[t];
      v:= j + dy[t];

      dec(c[u,v],k);
		end;
end;

procedure attempt(i,j: longint);
var
	k,t,u,v: longint;
begin
	if (j > n) then
  	if (i = n) then
    begin
			printres;    	
      closefile;
      halt;
    end
    else
    begin
    	inc(i);
      j:= 1;
    end;

  for k:= 0 to 1 do
  begin
  	a[i,j]:= k;

    for t:= 1 to 4 do
    begin
    	u:= i + dx[t];
      v:= j + dy[t];
			
    	inc(c[u,v],k);
    end;

    if not isvalid(i,j) then
    begin
    	setc(i,j,k);
    	continue;
    end;

    attempt(i,j + 1);

    setc(i,j,k);
  end;
end;

procedure process;
begin
	attempt(1,1);
end;

procedure output;
begin
	writeln(fo,'No solution');
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
