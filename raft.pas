uses math;
const
  inputfile = 'raft.inp';
  outputfile = 'raft.out';
var
  fi,fo: text;
  a,b,x,y,l,n: longint;


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
  readln(fi,x,a,y,b,l);
end;

function solve(num: longint): boolean;
var
	t,i,j,tx,ty,mintx,minty,m: longint;
begin
	tx:= x;
  ty:= y;
	for t:= 1 to l do
  begin
  	m:= maxlongint;

		for i:= 0 to tx do
    	for j:= 0 to ty do
      	if (a * i + b * j >= num) and (a * i + b * j < m) then
        begin
        	m:= a * i + b * j;
        	mintx:= i;
          minty:= j;
        end;

    if (m = maxlongint) then exit(false);

    dec(tx,mintx);
    dec(ty,minty);
  end;

  exit(true);
end;

procedure process;
var
  le,ri,mid,res: longint;
begin
  le:= 1; ri:= x * a + y * b;
  while (le <= ri) do
  begin
    mid:= (le + ri) div 2;
    if solve(mid) then
    begin
      res:= mid;
      le:= mid + 1;
    end
    else ri:= mid - 1;
  end;

  writeln(fo,res);
end;

procedure output;
begin
end;


BEGIN
  openfile;
  input;
  process;
  output;
  closefile;
END.
