uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 100;
  base = 1000000;
type
	bignum = array[0..100] of longint;
var
	fi,fo: text;
  ntest,test: longint;
  n: longint;
  f: array[1..maxN] of bignum;
	res: bignum;


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

procedure mul(a: bignum; num: longint; var c: bignum);
var
	i,carry: longint;
begin
	c[0]:= a[0];
  carry:= 0;
	for i:= 1 to c[0] do
  begin
		c[i]:= a[i] * num + carry;
    carry:= c[i] div base;
    if (c[i] >= base) then
    	c[i]:= c[i] mod base;
  end;

  if (carry > 0) then
  begin
  	inc(c[0]);
    c[c[0]]:= carry;
  end;
end;

procedure process;
var
	i: longint;
begin
	f[1][0]:= 1;
  f[1][1]:= 1;

  for i:= 2 to maxN do
		mul(f[i - 1],i,f[i]);
end;

procedure output;
var
	i: longint;
  s: string;
begin
	res:= f[n];

  write(fo,res[res[0]]);
  for i:= res[0] - 1 downto 1 do
  begin
		str(res[i],s);
    while (length(s) < 6) do
    	s:= '0' + s;	
		write(fo,s);
  end;
  writeln(fo);
end;


BEGIN
	openfile;
  process;
  readln(fi,ntest);
  for test:= 1 to ntest do
  begin
  	input;
    output;
  end;
  closefile;
END.
