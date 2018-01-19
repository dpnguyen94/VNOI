{
ID: ndchiph1
PROG: trough
LANG: PASCAL
}
uses math;
const
	inputfile = 'trough.in';
  outputfile = 'trough.out';
  maxN = 20 + 1;
  maxM = 100 + 1;
type
	qt = record
		c: array[1..maxN] of longint;
    num,count: longint;
  end;
var
	fi,fo: text;
  n,m: longint;
	list: array[1..maxM] of qt;
  a,res: array[0..maxN] of longint;
	exist: boolean;
  temp: qt;


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
	i,j: longint;
  ch: char;
begin
	readln(fi,n,m);
  for i:= 1 to m do
  	with list[i] do
    begin
    	num:= 0;
  		for j:= 0 to n - 1 do
    	begin
      	read(fi,ch);
        if (ch = '1') then
        begin
        	inc(num);
          c[num]:= j;
        end;
    	end;
      readln(fi,count);
    end;
end;

procedure sort;
var
	i,j: longint;
begin
	for i:= 1 to m - 1 do
  	for j:= i + 1 to m do
    	if (list[i].count < list[j].count) then
      begin
				temp:= list[i];
        list[i]:= list[j];
        list[j]:= temp;
      end;
end;

procedure solve;
var
	i,j,cnt: longint;
begin
	for i:= 1 to m do
   with list[i] do
   begin
   	cnt:= 0;
    for j:= 1 to num do
    	if (a[c[j]] = 1) then inc(cnt);

    if (cnt <> count) then exit;
   end;

   if exist then
   begin
   		writeln(fo,'NOT UNIQUE');
			closefile;
      halt;
   end;

   res:= a;
   exist:= true;
end;

procedure attempt(i: longint);
var
	j: longint;
begin
	if (i = n) then
  begin
  	solve;
		exit;
  end;

  for j:= 0 to 1 do
  begin
		a[i]:= j;
    attempt(i + 1);
  end;
end;

procedure process;
begin
	exist:= false;
	attempt(0);
end;

procedure output;
var
	i: longint;
begin
	if not exist then writeln(fo,'IMPOSSIBLE')
  else
  begin
  	for i:= 0 to n - 1 do write(fo,res[i]);
  	writeln(fo);
	end;
end;


BEGIN
	openfile;
  input;
  sort;
  process;
  output;
  closefile;
END.
