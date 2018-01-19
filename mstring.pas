uses math;
const
	inputfile = 'mstring.inp';
  outputfile = 'mstring.out';
  maxL = 1000 + 10;
  maxC = 1000000000;
//type

var
	fi,fo: text;
  a,b: ansistring;
  n,m: longint;
  f: array[1..maxL,1..maxL] of longint;
	last: array[1..maxL,'a'..'z'] of longint;


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
	readln(fi,a);
  readln(fi,b);
  n:= length(a);
  m:= length(b);

  for i:= m downto 1 do
  begin
  	last[i]:= last[i + 1];
    last[i,b[i]]:= i;
  end;
end;

procedure process;
var
	i,j: longint;
begin
end;

procedure output;
begin
	if (f[1,1] = maxC) then writeln(fo,0)
  else writeln(fo,f[1,1]);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
