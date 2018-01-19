uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 10000 + 10;
//type

var
	fi,fo: text;
  n: longint;
  f: array[1..maxN] of longint;


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
	readln(fi,n);
end;

procedure process;
var
	i,j,cnt: longint;
begin
	f[1]:= 1;
  for i:= 2 to maxN do
  begin
  	cnt:= 0;
    for j:= 1 to trunc(sqrt(i)) do
    	if (i mod j = 0) then inc(cnt);
    f[i]:= f[i - 1] + cnt;
  end;
end;

procedure output;
begin
	writeln(fo,f[n]);
end;


BEGIN
	openfile;
  process;
  input;
  output;
  closefile;
END.
