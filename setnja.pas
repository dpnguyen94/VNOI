{$INLINE ON}
uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 10010;
  base = 100000000;
type
	bignum = array[0..900] of longint;
var
	fi,fo: text;
  n: longint;
  s: ansistring;
  f: array[0..1] of bignum;
  power: bignum;


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
  n:= length(s);
end;

procedure init;
var
	i: longint;
begin
  power[0]:= 1;
  power[1]:= 1;
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

procedure mul(num1: bignum; num: longint;var res: bignum); inline;
var
	i,carry: longint;
begin
	res[0]:= num1[0];
  carry:= 0;
  for i:= 1 to res[0] do
  begin
		res[i]:= num1[i] * num + carry;
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
	i,prv,nxt: longint;
begin
  f[0][0]:= 1;
  f[0][1]:= 1;

  for i:= 1 to n do
  begin
  	prv:= (i + 1) mod 2;
    nxt:= i mod 2;

		if (s[i] = '*') then
    begin
    	mul(f[prv],5,f[nxt]);
      plus(f[nxt],power,f[nxt]);

      mul(power,3,power);
    end;	
    if (s[i] = 'P') then f[nxt]:= f[prv];
    if (s[i] = 'L') then mul(f[prv],2,f[nxt]);
		if (s[i] = 'R') then
    begin
    	mul(f[prv],2,f[nxt]);
      plus(f[nxt],power,f[nxt]);
    end;
  end;
end;

procedure output;
var
	i: longint;
  res: bignum;
begin
	res:= f[n mod 2];
  write(fo,res[res[0]]);
  for i:= res[0] - 1 downto 1 do
  begin
  	str(res[i],s);
    while (length(s) < 8) do s:= '0' + s;
    write(fo,s);
  end;
end;


BEGIN
	openfile;
  input;
  init;
  process;
  output;
  closefile;
END.
