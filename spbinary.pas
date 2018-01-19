{$INLINE ON}
uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 610;
  maxK = 610;
  base = 1000000000;
type
	bignum = array[0..25] of longint;
var
	fi,fo: text;
  n,k: longint;
  f: array[0..maxN] of bignum;


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
	readln(fi,n,k);
end;

procedure plus(num1,num2: bignum; var res: bignum); inline;
var
	i,carry: longint;
begin
	res[0]:= max(num1[0],num2[0]);
  carry:= 0;
  for i:= 1 to res[0] do
  begin
  	res[i]:= num1[i] + num2[i] + carry;
    carry:= res[i] div base;
    if (res[i] >= base) then
    	res[i]:= res[i] mod base;
  end;

  if (carry > 0) then
  begin
  	inc(res[0]);
    res[res[0]]:= carry;
  end;
end;

procedure process;
var
	i,j: longint;
begin
	f[0][0]:= 1;
	f[0][1]:= 1;

  for i:= 1 to n do
  	for j:= 1 to k do
      if (i >= j) then
        plus(f[i],f[i-j],f[i]);
end;

procedure output;
var
	i: longint;
	res: bignum;
  s: ansistring;
begin
	plus(f[n],f[n],res);

  write(fo,res[res[0]]);
  for i:= res[0] - 1 downto 1 do
  begin
		str(res[i],s);
    while (length(s) < 9) do s:= '0' + s;
    write(fo,s);
  end;
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
