uses math;
const
	inputfile = '';
  outputfile = '';
  maxL = 80 + 5;
  LM = 1000 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  a,b: string;
  lenga,lengb,cnt: longint;
  f: array[0..maxL,0..maxL] of longint;
  vs: array['a'..'z',1..maxL] of boolean;
  res: array[1..LM] of string;


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
begin
	readln(fi,a);
  readln(fi,b);
  lenga:= length(a);
  lengb:= length(b);

  for i:= 1 to lenga do
  	for j:= 1 to lengb do
    	if (a[i] = b[j]) then
      	f[i,j]:= f[i - 1,j - 1] + 1
      else
      	f[i,j]:= max(f[i - 1,j],f[i,j -1]);
end;

procedure attempt(i,j,leng: longint; s: string);
var
	i1,j1,k: longint;
  ch: char;
begin
	if (leng = 0) then
  begin
  	inc(cnt);
    res[cnt]:= s;
  end;

	for i1:= i downto 1 do
  	for j1:= j downto 1 do
    	if (f[i1,j1] = leng) and (a[i1] = b[j1]) then
      	if not vs[a[i1],leng] then
        begin
        	vs[a[i1],leng]:= true;

          for ch:= 'a' to 'z' do
          	for k:= leng - 1 downto 1 do
            	vs[ch,k]:= false;
            	
          attempt(i1 - 1,j1 - 1,leng - 1,a[i1] + s);
        end;
end;

procedure sort(le,ri: longint);
var
	i,j: longint;
  t,z: string;
begin
	if (le >= ri) then exit;
  i:= le; j:= ri;
  t:= res[(le + ri) div 2];

  repeat
  	while (res[i] < t) do inc(i);
    while (res[j] > t) do dec(j);

    if (i <= j) then
    begin
			z:= res[i]; res[i]:= res[j]; res[j]:= z;

      inc(i);
      dec(j);
    end;
  until i > j;

  sort(le,j);
  sort(i,ri);
end;

procedure process;
var
	i: longint;
begin
	cnt:= 0;
  fillchar(vs,sizeof(vs),false);
	attempt(lenga,lengb,f[lenga,lengb],'');

  sort(1,cnt);
  for i:= 1 to cnt do
  	writeln(fo,res[i]);

  writeln(fo);
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
