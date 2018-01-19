uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 500000 + 10;
//type

var
	fi,fo: text;
  n,m,nodd: longint;
  s: string;
  odd: array[1..LM] of longint;
  a: array[1..10] of longint;
  b: array[1..5] of longint = (1,3,5,7,9);


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
  readln(fi);
end;

procedure attempt(i: longint);
var
	j,temp: longint;
begin
	if (i > m) then
  begin
  	temp:= 0;
		for j:= 1 to m do
    	temp:= temp * 10 + a[j];
    inc(nodd);
    odd[nodd]:= temp;

    exit;
  end;                   	

	for j:= 1 to 5 do
  begin
  	a[i]:= b[j];
    attempt(i + 1);
  end;
end;

procedure init;
var
	i: longint;
begin
	nodd:= 0;
	for i:= 1 to 8 do
  begin
  	m:= i;
  	attempt(1);
  end;
end;

procedure process;
var
	i,res,temp,le,ri,mid,maxpos,pos: longint;
begin
	le:= 1; ri:= nodd;
  while (le <= ri) do
  begin
  	mid:= (le + ri) div 2;
    if (odd[mid] < n) then le:= mid + 1
    else
    begin
    	maxpos:= mid;
      ri:= mid - 1;
    end;
  end;

  //
  if (n = 100000000) then
  begin
  	writeln(fo,n);
    exit;
  end;

	res:= maxlongint;
	le:= 1;
  ri:= maxpos;

  while (le <= ri) do
		if (odd[le] + odd[ri] >= n) then
    begin
    	res:= min(res,odd[le] + odd[ri]);
      if (res = n) then break;

      dec(ri);
    end
    else inc(le);
	
  writeln(fo,res);
end;


BEGIN
	openfile;
  init;
  while TRUE do
  begin
  	readln(fi,s);
    if (s = '[END]') then break;
    input;
    process;
  end;
  closefile;
END.
