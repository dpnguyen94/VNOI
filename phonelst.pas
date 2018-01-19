uses math;
const
	inputfile = 'phonelst.in1';
  outputfile = 'phonelst.out';
  maxN = 10000 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n: longint;
  s: array[1..maxN] of string;


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
  	readln(fi,s[i]);
end;

procedure sort(le,ri: longint);
var
	i,j: longint;
  t,z: string;
begin
	if (le >= ri) then exit;
  i:= le; j:= ri;
  t:= s[(le + ri) div 2];

  repeat
  	while (s[i] < t) do inc(i);
    while (s[j] > t) do dec(j);

    if (i <= j) then
    begin
    	z:= s[i]; s[i]:= s[j]; s[j]:= z;

      inc(i);
      dec(j);
    end;
  until i > j;
	
  sort(le,j);
  sort(i,ri);
end;

function search(st: string): boolean;
var
	le,ri,mid: longint;
begin
	le:= 1; ri:= n;
  while (le <= ri) do
  begin
		mid:= (le + ri) div 2;
    if (s[mid] = st) then exit(true);
    if (s[mid] < st) then le:= mid + 1
    else ri:= mid - 1;
  end;

  exit(false);
end;

procedure process;
var
	i,j: longint;
  st: string;
begin
	sort(1,n);

	//
  for i:= 1 to n do
  begin
		st:= '';
    for j:= 1 to length(s[i]) - 1 do
    begin
			st:= st + s[i][j];

      if search(st) then
      begin
      	writeln(fo,'NO');
        exit;
      end;
    end;
  end;

  writeln(fo,'YES');
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  readln(fi,ntest);
  for test:= 1 to ntest do
  begin
  	input;
    process;
  end;
  closefile;
END.
