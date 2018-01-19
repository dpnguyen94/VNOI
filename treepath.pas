uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 2000 + 10;
  base = 100000000;
type
	bignum = array[0..2000] of longint;
var
	fi,fo: text;
  s: ansistring;
  n: longint;
	new,old,f: array[0..1] of bignum;
  power,sum: bignum;


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
	readln(fi,s);
	n:= length(s);
end;

procedure plus(num1,num2: bignum; var res: bignum);
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

procedure multiply(num1: bignum; num: longint; var res: bignum);
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

procedure init;
begin
	power[0]:= 1;
  power[1]:= 1;
end;

procedure process;
var
	i,prev,next: longint;
  tmp: bignum;
begin
	old[0][0]:= 1;
	old[0][1]:= 1;
  f[0]:= old[0];

  for i:= 1 to n do
  begin
  	next:= i mod 2;
    prev:= (i + 1) mod 2;

		if (s[i] = '*') then
    begin
    	multiply(old[prev],9,new[next]);	
      multiply(power,3,tmp);
      plus(new[next],tmp,new[next]);

      multiply(f[prev],4,f[next]);
      plus(f[next],new[next],f[next]);
			plus(old[prev],new[next],old[next]);

			multiply(power,4,power);
    end;

    if (s[i] = 'L') then
    begin
    	multiply(old[prev],3,new[next]);
      plus(f[prev],new[next],f[next]);

      old[next]:= new[next];
    end;

    if (s[i] = 'C') then
    begin
    	multiply(old[prev],3,new[next]);
      plus(new[next],power,new[next]);

      plus(f[prev],new[next],f[next]);
      old[next]:= new[next];
    end;

    if (s[i] = 'R') then
    begin
    	multiply(old[prev],3,new[next]);
      multiply(power,2,tmp);
      plus(new[next],tmp,new[next]);

      plus(f[prev],new[next],f[next]);
      old[next]:= new[next];
    end;

    if (s[i] = 'S') then
    begin
    	new[next]:= old[prev];
      f[next]:= f[prev];
      old[next]:= new[next];
    end;
  end;
end;

procedure output;
var
	i: longint;
begin
	sum:= f[n mod 2];
  write(fo,sum[sum[0]]);
  for i:= sum[0] - 1 downto 1 do
  begin
  	str(sum[i],s);
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
