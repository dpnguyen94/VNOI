uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 10000000;
//type

var
	fi,fo: text;
  res: int64;
  n,k: longint;

  a: array[1..maxN] of longint;

  cleft,cright: longint;
  sleft,sright: int64;


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
	i,num: longint;
begin
  n:= 10000000;

  //
	readln(fi,k);
  for i:= 1 to k do
  begin
    readln(fi,num);
    if (num = 1) then
    begin
    	inc(cleft);
    	inc(a[1]);
      continue;
    end;
		
    if (num > 5000000) then
    begin
    	inc(cleft);
    	sleft:= sleft + (n + 1 - num);
    end
    else
    	sright:= sright + (num - 1);

    inc(a[num]);
  end;
end;

procedure process;
var
	i,j: longint;
begin
  res:= sleft + sright;

  //
  for i:= 2 to n do
  begin
  	j:= i + 4999999;
	  if (j > n) then j:= j - n;

    //
  	sleft:= sleft - a[j] * 5000001 + cleft;
  	sright:= sright - (k - cleft) + a[j] * 4999999;
    cleft:= cleft - a[j] + a[i];

    if (sleft + sright < res) then
    	res:= sleft + sright;
  end;

  writeln(fo,res);
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
