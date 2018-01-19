uses math;
const
  base = 10;
var
  ntest,test: longint;
  c1,c2: char;
  a: longint;
  b: int64;

function modpow(n: longint; p: int64): int64;
var
	res: int64;
begin
	res:= 1;
	while (p > 0) do
  begin
		if (p mod 2 = 1) then
    	res:= (res * n) mod base;
    n:= (n * n) mod base;

    p:= p div 2;
  end;

  exit(res);
end;


BEGIN
  readln(ntest);
  for test:= 1 to ntest do
  begin
  	while TRUE do
    begin
    	c1:= c2;
    	read(c2);
      if (c2 = ' ') then
      begin
      	a:= ord(c1) - ord('0');
      	readln(b);
        break;
      end;
    end;

    writeln(modpow(a,b));
  end;
END.
