uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 100000 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n,longest: longint;
  a,f,d1,d2: array[0..maxN] of longint;
  res: array[1..maxN] of boolean;


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
	i: longint;
begin
	readln(fi,n);
  for i:= 1 to n do
  	read(fi,a[i]);
end;

procedure process;
var
	i,j,le,ri,mid,lmax: longint;
begin
	fillchar(f,sizeof(f),0);
  a[0]:= -maxlongint;
  lmax:= 0;
  for i:= 1 to n do
  begin
		le:= 0; ri:= lmax;
    while (le <= ri) do
    begin
			mid:= (le + ri) div 2;
      if (a[i] > a[f[mid]]) then
      begin
				j:= mid;
        le:= mid + 1;
      end
      else ri:= mid - 1;
    end;
    d1[i]:= j + 1;
    f[j + 1]:= i;

    lmax:= max(lmax,j + 1);
  end;
  longest:= lmax;

	fillchar(f,sizeof(f),0);
  a[0]:= maxlongint;
  lmax:= 0;
  for i:= n downto 1 do
  begin
		le:= 0; ri:= lmax;
    while (le <= ri) do
    begin
			mid:= (le + ri) div 2;
      if (a[i] < a[f[mid]]) then
      begin
				j:= mid;
        le:= mid + 1;
      end
      else ri:= mid - 1;
    end;
    d2[i]:= j + 1;
    f[j + 1]:= i;

    lmax:= max(lmax,j + 1);
  end;
end;

procedure output;
var
	i,cnt: longint;
begin
	fillchar(res,sizeof(res),false);
	for i:= 1 to n do
  	if (d1[i] + d2[i] - 1 = longest) then
    	res[a[i]]:= true;

  cnt:= 0;
  for i:= 1 to n do
  	if res[i] then
    begin
    	inc(cnt);
      a[cnt]:= i;
    end;

  writeln(fo,cnt);
  for i:= 1 to cnt do
  	write(fo,a[i],' ');
  writeln(fo);
end;


BEGIN
	openfile;
  ntest:= 10;
  for test:= 1 to ntest do
  begin
  	input;
    process;
    output;
  end;
  closefile;
END.
