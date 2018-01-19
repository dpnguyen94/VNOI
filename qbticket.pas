uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 100000 + 10;
//type

var
	fi,fo: text;
  n,s,t: longint;
  l,c: array[1..3] of longint;
  a,d,f: array[0..maxN] of int64;


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
	for i:= 1 to 3 do 	
  	read(fi,l[i]);
  for i:= 1 to 3 do
  	read(fi,c[i]);

  readln(fi,n);
  readln(fi,s,t);

  for i:= 2 to n do
  	read(fi,a[i]);

  //
	for i:= 1 to n - 1 do
  	d[i]:= a[i + 1] - a[i];
end;

function money(dist: int64): longint;
var
	i: longint;
begin
	for i:= 1 to 3 do
  	if (dist <= l[i]) then exit(c[i]);
end;

procedure process;
var
	i,j: longint;
  dist,temp: int64;
begin
	f[s]:= 0;
  for i:= s + 1 to t do
  begin
    f[i]:= high(int64);

    dist:= 0;
    for j:= i - 1 downto s do
    begin
    	dist:= dist + d[j];
      if (dist > l[3]) then break;

      temp:= f[j] + money(dist);
      if (f[i] > temp) then
      	f[i]:= temp;
    end;
  end;
end;

procedure output;
begin
	writeln(fo,f[t]);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
