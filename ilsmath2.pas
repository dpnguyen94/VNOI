uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 1000000000;
  pi = 3.14159265;
  e = 2.71828183;
//type

var
	fi,fo: text;
  n: longint;


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

function log10(num: real): real;
begin
	exit(ln(num) / ln(10));
end;

function getdigit(num: longint): int64;
var
	num1,num2: real;
begin
	num1:= log10(sqrt(2 * pi) * sqrt(num));
  num2:= num * log10(num / e);

  exit(trunc(num1 + num2) + 1);
end;

procedure process;
var
	i,le,ri,mid,res: longint;
  temp: int64;
begin
	if (n = 1) then
  begin
  	writeln(fo,3);
    for i:= 1 to 3 do
    	writeln(fo,i);
    exit;
  end;

  if (n = 3) then
  begin
  	writeln(fo,2);
    for i:= 5 to 6 do
    	writeln(fo,i);
    exit;
  end;

  res:= -1;
  le:= 1; ri:= maxN;
  while (le <= ri) do
  begin
  	mid:= (le + ri) div 2;

    temp:= getdigit(mid);

    if (temp = n) then
    begin
    	res:= mid;
      break;
    end;
    if (temp > n) then ri:= mid - 1;
    if (temp < n) then le:= mid + 1;
  end;

  if (res = -1) then writeln(fo,'NO')
  else
  begin
  	writeln(fo,1);
    writeln(fo,res);
  end;
end;

procedure output;
begin
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
