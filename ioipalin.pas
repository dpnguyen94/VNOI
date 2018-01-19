uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 5000 + 10;
//type

var
	fi,fo: text;
  n: longint;
  s: ansistring;
  f: array[0..maxN,0..1] of longint;


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
  readln(fi,s);
end;

procedure process;
var
	i,j,nxt,prv: longint;
begin
	for j:= 1 to n do
  begin
		nxt:= j mod 2;
    prv:= (j + 1) mod 2;

    for i:= j downto 1 do
    	if (s[i] = s[j]) then
      	f[i,nxt]:= f[i + 1,prv]
      else
      	f[i,nxt]:= min(f[i + 1,nxt],f[i,prv]) + 1;
  end;
end;

procedure output;
begin
	writeln(fo,f[1,n mod 2]);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
