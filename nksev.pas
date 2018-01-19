{$INLINE ON}
uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 4000 + 10;
  maxL = 300000 + 10;
  base = 1337377;
  LM = 100000 + 10;
//type

var
	fi,fo: text;
	n,len,maxlen,maxprime: longint;
  s: ansistring;
  w: array[1..maxN] of string;
  num,a: array[1..maxN] of longint;
  h: array[0..LM] of longint;

  f: array[0..maxL] of longint;
  st: string;
  count: longint;


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
	readln(fi,s);
  len:= length(s);
  readln(fi,n);
  maxlen:= 0;
  for i:= 1 to n do
  begin
  	readln(fi,w[i]);
    maxlen:= max(maxlen,length(w[i]));
  end;
end;

procedure init;
var
	i,j,tmp: longint;
begin
	maxprime:= 100003;

  //
  for i:= 1 to n do
  begin
  	tmp:= 0;
  	for j:= length(w[i]) downto 1 do
    	tmp:= (tmp * 10000 + ord(w[i][j])) mod maxprime;
		
    num[i]:= tmp;
    inc(h[num[i]]);
  end;

  for i:= 1 to maxprime + 1 do
  	h[i]:= h[i-1] + h[i];

  for i:= 1 to n do
  begin
		j:= num[i];
		a[h[j]]:= i;
    dec(h[j]);
  end;
end;

function search(hnum: longint): boolean; inline;
var
	i: longint;
begin
	for i:= h[hnum] + 1 to h[hnum + 1] do
    if (w[a[i]] = st) then exit(true);

  exit(false);
end;

procedure process;
var
  i,j,t,tmp: longint;
begin
	f[0]:= 1;
	for i:= 1 to len do
  begin
		t:= max(0,i - maxlen);
    tmp:= 0;
    st:= '';
    for j:= i downto t+1 do
    begin
    	st:= s[j] + st;
      tmp:= (tmp * 10000 + ord(s[j])) mod maxprime;

    	if search(tmp) then
      	f[i]:= (f[i] + f[j-1]) mod base;
    end;
  end;
end;

procedure output;
begin
	writeln(fo,f[len]);
end;


BEGIN
	openfile;
  input;
  init;
  process;
  output;
  closefile;
END.
