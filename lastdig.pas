uses math;
const
  base = 10;
var
  ntest,test: longint;
  a,b: longint;

function modpow(n,p: longint): int64;
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
  	readln(a,b);
    writeln(modpow(a,b));
  end;
END.
