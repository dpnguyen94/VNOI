uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 151;
  base = 1000;
type
	bignum = array[0..50] of longint;
var
	fi,fo: text;
  n: longint;
  f: array[0..2 * maxN] of bignum;


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

function nhan(a,b:bignum): bignum;
var i,j,carry,x:longint;
begin
     fillchar(nhan,sizeof(nhan),0);
     nhan[0]:=a[0] + b[0] -1;
     for i:= 1 to a[0] do
        for j:=1 to b[0] do
            nhan[i+j-1]:= nhan[i+j-1]+ a[i] * b[j];
     carry:=0;
     for i:=1 to nhan[0] do
          begin
               x:=nhan[i]+ carry;
               nhan[i]:= x mod base;
               carry:=x div base;
          end;
     if carry>0 then
          begin
               inc(nhan[0]);
               nhan[nhan[0]]:=carry;
          end;
end;

procedure process;
var
	t,p: longint;
  tmp: bignum;
begin
  f[0][0]:= 1;
  f[0][1]:= 1;

	for t:= 2 to 2 * maxN do
  	if (t mod 2 = 0) then
    begin
			for p:= 2 to t do
      if (p mod 2 = 0) then
      begin
        tmp:= nhan(f[p - 2],f[t - p]);
        plus(f[t],tmp,f[t]);
      end;
    end;
end;

procedure output;
var
	i: longint;
  res: bignum;
  s: ansistring;
begin
	res:= f[2 * n];
  write(fo,res[res[0]]);
  for i:= res[0] - 1 downto 1 do
  begin
  	str(res[i],s);
    while (length(s) < 3) do s:= '0' + s;
    write(fo,s);
  end;
  writeln(fo);
end;


BEGIN
	openfile;
  process;
	while TRUE do
  begin
  	readln(fi,n);
    if (n = -1) then break;
    output;
  end;
  closefile;
END.
