{$INLINE ON}
uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 10000 + 10;
  base = 1000000000;
type
	bignum = array[0..350] of longint;
var
	fi,fo: text;
  n,k: longint;
  res,t: bignum;
  f,g: array[0..maxN] of bignum;


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

procedure plus(a,b: bignum; var c: bignum); inline;
var
	i,carry: longint;
begin
	c[0]:= max(a[0],b[0]);
  carry:= 0;
  for i:= 1 to c[0] do
	begin
  	c[i]:= a[i] + b[i] + carry;
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

procedure input;
var
	i: longint;
begin
	readln(fi,n,k);
  dec(k);
  res[0]:= 1;
  res[1]:= 1;
  for i:= 1 to n do
  	plus(res,res,res);
end;

procedure minus(a,b: bignum; var c: bignum); inline;
var
	i,carry: longint;
begin
	c[0]:= a[0];
  carry:= 0;
  for i:= 1 to c[0] do
  begin
		c[i]:= a[i] - b[i] + carry;
    if (c[i] < 0) then
    begin
			c[i]:= c[i] + base;
      carry:= -1;
    end
    else carry:= 0;
  end;

  while (c[0] > 0) and (c[c[0]] = 0) do dec(c[0]);
end;

procedure process;
var
	i: longint;
  sum: bignum;
begin
	g[0][0]:= 1;
  g[0][1]:= 1;

  fillchar(sum,sizeof(sum),0);
  sum[0]:= 1;
  sum[1]:= 1;

  for i:= 1 to n do
  begin
		plus(f[i],sum,f[i]);

    if (i >= k) then
    	minus(sum,g[i-k],sum);

    plus(g[i-1],f[i-1],g[i]);
    plus(sum,g[i],sum);
  end;
end;

procedure output;
var
	i: longint;
  s: string;
begin
	if (k > 0) then
  begin
		minus(res,f[n],res);
  	minus(res,g[n],res);
  end
  else
  begin
  	t[0]:= 1;
    t[1]:= 1;
    minus(res,t,res);
  end;

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
