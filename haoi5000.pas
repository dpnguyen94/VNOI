uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 1000000 + 10;
//type

var
	fi,fo: text;
  n,k,n2: longint;

  a: array[1..maxN] of longint;
  res: array[1..maxN] of int64;

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
	readln(fi,n,k);
  if (n mod 2 = 0) then n2:= n div 2
  else n2:= n div 2 + 1;

  for i:= 1 to k do
  begin
    read(fi,num);
    if (num = 1) then
    begin
    	inc(cleft);
    	inc(a[1]);
      continue;
    end;
		
    if (num > n2) then
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
  res[1]:= sleft + sright;

  //
  for i:= 2 to n do
  begin
  	j:= i - 1 + n2;
	  if (j > n) then j:= j - n;

    //
  	sleft:= sleft - a[j] * n2 + (cleft - a[j]);
  	sright:= sright - (k - cleft) + a[j] * (n2 - 1);
    cleft:= cleft - a[j] + a[i];

    res[i]:= sleft + sright;
  end;
end;

procedure output;
var
	i,cnt: longint;
  mindist: int64;
begin
	mindist:= high(int64);
	for i:= 1 to n do
  	if (res[i] < mindist) then mindist:= res[i];
  writeln(fo,mindist);

  cnt:= 0;
  for i:= 1 to n do
  	if (res[i] = mindist) then
    begin
    	inc(cnt);
      a[cnt]:= i;
    end;
  writeln(fo,cnt);
  for i:= 1 to cnt do
  	write(fo,a[i],' ');
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
