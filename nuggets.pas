{
ID: ndchiph1
PROG: nuggets
LANG: PASCAL
}
uses math;
const
	inputfile = 'nuggets.in';
  outputfile = 'nuggets.out';
  LM = 700000;
  maxN = 11;
//type
var
	fi,fo: text;
  n: longint;
  a: array[1..maxN] of longint;
	f: array[0..LM] of boolean;


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

function gcd(x,y: longint): longint;
var
	t: longint;
begin
	while (y > 0) do
  begin
  	t:= x mod y;
    x:= y;
    y:= t;
  end;	

  exit(x);
end;

function lcm(x,y: longint): longint;
begin
	exit(x * y div gcd(x,y));
end;

procedure output(res: longint);
begin
	writeln(fo,res);
  closefile;
  halt;
end;


procedure input;
var
	i,j,t: longint;
begin
	readln(fi,n);
  for i:= 1 to n do
  	readln(fi,a[i]);

	//sort;
  for i:= 1 to n-1 do
  	for j:= i+1 to n do
    	if (a[i] > a[j]) then
      begin
      	t:= a[i];
        a[i]:= a[j];
        a[j]:= t;
      end;

  //check;
  if (n = 1) or (a[i] = 1) then output(0);
  t:= a[1];
  for i:= 2 to n do
  	t:= gcd(t,a[i]);
  if (t <> 1) then output(0);
end;

procedure process;
var
	i,j,num,maxval: longint;
begin
	maxval:= lcm(a[n],a[n-1]);

	f[0]:= true;
	for i:= 1 to n do
  begin
    for j:= a[i] to maxval do
    	if f[j-a[i]] then f[j]:= true;
  end;

  for i:= maxval downto 1 do
  	if not f[i] then output(i);
end;


BEGIN
	openfile;
  input;
  process;
  closefile;
END.
