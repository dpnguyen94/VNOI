uses math;
const
	inputfile = '';
  outputfile = '';
  base = 1000000007;
//type

var
	fi,fo: text;
  n,k: longint;
  s: string;


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
  readln(fi,k);
  readln(fi,n);
  readln(fi);
end;

function modpow(num,p: int64): int64;
var
	res: int64;
begin
	res:= 1;
  while (p > 0) do
  begin
  	if (p mod 2 = 1) then
    	res:= (res * num) mod base;
    num:= (num * num) mod base;

    p:= p div 2;
  end;

  exit(res);	
end;

procedure process;
var
	i: longint;
	num1,num2: int64;
begin
	num1:= 1;
  for i:= 0 to k do
  	num1:= (num1 * (n + i)) mod base;

  num2:= 1;
  for i:= 2 to k + 1 do
  	num2:= (num2 * i) mod base;

	writeln(fo,(num1 * modpow(num2,base - 2)) mod base);

  //a ^ -1 = a ^ (p - 2) (mod p)
  //p is a prime
end;


BEGIN
	openfile;
  while TRUE do
  begin
  	readln(fi,s);
    if (s = '[END]') then break;
    input;
    process;
  end;
  closefile;
END.
