uses math;
const
	inputfile = 'nksev.in1';
  outputfile = 'nksev2.out';
  maxL = 300000 + 10;
  maxN = 4000 + 10;
  base = 1337377;
//type
var
	fi,fo: text;
  s: ansistring;
  n: longint;
	f: array[0..maxL] of longint;
  w: array[1..maxN] of string;

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
	readln(fi,s);
  readln(fi,n);
  for i:= 1 to n do
  	readln(fi,w[i]);
end;

function inset(st: string): boolean;
var
	i: longint;
begin
	for i:= 1 to n do
  	if (w[i] = st) then exit(true);

  exit(false);
end;

procedure process;
var
	i,j,t: longint;
  st: string;
begin
	f[0]:= 1;
  for i:= 1 to length(s) do
  begin
  	t:= max(0,i - 100);
    st:= '';
    for j:= i downto t+1 do
    begin
    	st:= s[j] + st;
			if inset(st) then
      	f[i]:= (f[i] + f[j-1]) mod base;
    end;
  end;
end;

procedure output;
begin
	writeln(fo,f[length(s)]);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
