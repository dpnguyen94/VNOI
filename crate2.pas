uses math;
const
	inputfile = 'crate.in1';
  outputfile = 'crate2.out';
  maxN = 1000;
//type

var
	fi,fo: text;
  n: longint;
  a,h: array[1..maxN] of longint;


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
	readln(fi,n);
  for i:= 1 to n do
  	readln(fi,a[i],h[i]);
end;

procedure process;
var
	i,j,cnt: longint;
begin
	for i:= 1 to n do
  begin
  	cnt:= 0;
    for j:= 1 to n do
    	if (a[i] >= a[j]) and (h[i] >= h[j])
      	and (a[i] + h[i] > a[j] + h[j]) then inc(cnt);
    writeln(fo,cnt);
  end;
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
