{$INLINE ON}
uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 10000 + 1;
  LM = 100000 + 1;
  maxK = 50;
  base = 5000000;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n,k: longint;
  a: array[1..maxN] of longint;
  exist: array[0..LM] of boolean;
  num: array[0..LM] of longint;
  f: array[1..maxK,1..maxN] of longint;


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
	i,cnt: longint;
begin
	readln(fi,n,k);
  for i:= 1 to n do
  begin
  	readln(fi,a[i]);
    exist[a[i]]:= true;
  end;

  cnt:= 0;
  for i:= 0 to LM do
  	if exist[i] then
    begin
    	inc(cnt);
      num[i]:= cnt;
    end;

  for i:= 1 to n do
  	a[i]:= num[a[i]];
end;

procedure update(pos,val,num: longint); inline;
begin
	while (val <= maxN) do
  begin
		f[pos,val]:= (f[pos,val] + num) mod base;
    val:= val + (val and (-val));
  end;
end;

function get(pos,val: longint): longint; inline;
var
	temp: longint;
begin
	temp:= 0;
	while (val >= 1) do
  begin
  	temp:= (temp + f[pos,val]) mod base;
    val:= val - (val and (-val));
  end;

  exit(temp);
end;

procedure process;
var
	i,j,temp,res: longint;
begin
	res:= 0;
	for i:= 1 to n do
  begin
  	update(1,a[i],1);
    if (k = 1) then inc(res);

    for j:= 2 to k do
    begin
    	temp:= get(j - 1,a[i] - 1);
      update(j,a[i],temp);

      if (j = k) then
      	res:= (res + temp) mod base;
    end;
  end;

  writeln(fo,res);
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
