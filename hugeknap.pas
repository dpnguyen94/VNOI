uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 10000 + 10;
  maxM = 1000 + 10;
//type
var
	fi,fo: text;
  n,m,ntest,test: longint;
  w,v: array[1..maxN] of longint;
  f: array[0..1,0..maxM] of longint;
  tr: array[1..maxN,0..maxM] of boolean;


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
	readln(fi,n,m);
  for i:= 1 to n do
  	read(fi,w[i]);
  for i:= 1 to n do
  	read(fi,v[i]);
end;

procedure process;
var
	i,j,prev,next: longint;
begin
	fillchar(f[0],sizeof(f[0]),0);
	fillchar(tr,sizeof(tr),false);

	for i:= 1 to n do
  begin
  	prev:= (i + 1) mod 2;
		next:= i mod 2;

  	for j:= 1 to m do
    begin
    	f[next,j]:= f[prev,j];

    	if (j >= w[i]) then
      	if (f[next,j] < f[prev,j - w[i]] + v[i]) then
        begin
      		f[next,j]:= f[prev,j - w[i]] + v[i];
          tr[i,j]:= true;
        end;
    end;
  end;
end;

procedure output;
var
	i,cnt: longint;
  kq: array[1..maxN] of longint;
begin
	write(fo,f[n mod 2,m],' ');
  cnt:= 0;
  while (n <> 0) do
  begin
  	if tr[n,m] then
    begin
    	inc(cnt);
      kq[cnt]:= n;
      m:= m - w[n];
    end;
		dec(n);
  end;
  writeln(fo,cnt);
  for i:= cnt downto 1 do
  	write(fo,kq[i],' ');
  writeln(fo);
end;


BEGIN
	openfile;
  readln(fi,ntest);
  for test:= 1 to ntest do
  begin
  	input;
  	process;
  	output;
  end;
  closefile;
END.
