uses math;
const
	inputfile = 'goosiper.inp';
  outputfile = 'goosiper.out';
  maxN = 2100 + 10;
  maxM = 12000 + 10;
  base = 2113;
//type

var
	fi,fo: text;
  n,m: longint;
  s: array[1..maxN] of string;
  hash: array[0..base,1..100] of longint;
  c: array[0..base] of longint;

  x,y: array[1..maxM] of longint;
  h: array[1..maxN] of longint;
  a: array[1..2 * maxM] of longint;
  vs: array[1..maxN] of boolean;


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

function find(ss: string): longint;
var
	i,temp: longint;
begin
	temp:= 0;
  for i:= 1 to length(ss) do
  	temp:= (temp + ord(ss[i]) * i) mod base;
	
  for i:= 1 to c[temp] do
  	if (ss = s[hash[temp,i]]) then exit(hash[temp,i]);
end;

procedure input;
var
	i,j,temp,u,v: longint;
  st,ss: string;
begin
	fillchar(hash,sizeof(hash),0);
  fillchar(c,sizeof(c),0);

	for i:= 1 to n do
  begin
  	readln(fi,s[i]);
    temp:= 0;
    for j:= 1 to length(s[i]) do
			temp:= (temp + ord(s[i][j]) * j) mod base;

    inc(c[temp]);
    hash[temp,c[temp]]:= i;
  end;

  fillchar(h,sizeof(h),0);
  for i:= 1 to m do
  begin
  	readln(fi,st);

    ss:= '';
    while (st[1] <> ' ') do
    begin
    	ss:= ss + st[1];
      delete(st,1,1);
    end;
    x[i]:= find(ss);

    delete(st,1,1);
    y[i]:= find(st);

    inc(h[x[i]]);
    inc(h[y[i]]);
  end;

  for i:= 2 to n + 1 do
  	h[i]:= h[i - 1] + h[i];

  for i:= 1 to m do
  begin
  	u:= x[i];
    v:= y[i];

    a[h[u]]:= v;
    a[h[v]]:= u;

    dec(h[u]);
    dec(h[v]);
  end;

  readln(fi);
end;

procedure process;
//var
begin
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  while true do
  begin
  	readln(fi,n,m);
    if (n = 0) and (m = 0) then break;
    input;
    process;
  end;
  closefile;
END.
