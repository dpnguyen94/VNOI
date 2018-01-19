uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 250000 + 10;
  maxK = 5000 + 10;
  base = 65536;
//type

var
	fi,fo: text;
  ntest,test: longint;
  seed,mul,add,n,k: longint;
  a,mda,pos,h: array[0..maxN] of longint;
  ha,hb: array[0..maxK] of longint;
  na,nb: longint;


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
	readln(fi,seed,mul,add,n,k);
  a[1]:= seed;
  for i:= 2 to n do
  	a[i]:= (a[i - 1] * int64(mul) + add) mod base;	
end;

procedure pusha(i: longint);
var
	c,p: longint;
begin             	
	inc(na);
  h[i]:= 1;

	c:= na;
  repeat
  	p:= c div 2;
		if (p = 0) or (a[i] <= a[ha[p]]) then break;

    ha[c]:= ha[p];
    pos[ha[c]]:= c;
    c:= p;
  until false;

  ha[c]:= i;
  pos[i]:= c;
end;

procedure popa(ps: longint);
var
	i,p,c: longint;
begin
	i:= ha[na];
  dec(na);

  c:= ps;
  repeat
  	p:= c div 2;
    if (p = 0) or (a[i] <= a[ha[p]]) then break;

    ha[c]:= ha[p];
    pos[ha[c]]:= c;
    c:= p;
  until false;

  p:= c;
  repeat
  	c:= p * 2;
    if (c < na) and (a[ha[c]] < a[ha[c + 1]]) then inc(c);
    if (c > na) or (a[i] >= a[ha[c]]) then break;

    ha[p]:= ha[c];
    pos[ha[p]]:= p;
    p:= c;
  until false;

  ha[p]:= i;
  pos[i]:= p;
end;

procedure pushb(i: longint);
var
	c,p: longint;
begin             	
	inc(nb);
  h[i]:= 2;

	c:= nb;
  repeat
  	p:= c div 2;
		if (p = 0) or (a[i] >= a[hb[p]]) then break;

    hb[c]:= hb[p];
    pos[hb[c]]:= c;
    c:= p;
  until false;

  hb[c]:= i;
  pos[i]:= c;
end;

procedure popb(ps: longint);
var
	i,p,c: longint;
begin
	i:= hb[nb];
  dec(nb);

  c:= ps;
  repeat
  	p:= c div 2;
    if (p = 0) or (a[i] >= a[hb[p]]) then break;

    hb[c]:= hb[p];
    pos[hb[c]]:= c;
    c:= p;
  until false;

  p:= c;
  repeat
  	c:= p * 2;
    if (c < nb) and (a[hb[c]] > a[hb[c + 1]]) then inc(c);
    if (c > nb) or (a[i] <= a[hb[c]]) then break;

    hb[p]:= hb[c];
    pos[hb[p]]:= p;
    p:= c;
  until false;

  hb[p]:= i;
  pos[i]:= p;
end;

procedure process;
var
	i,temp: longint;
begin
	na:= 0;
  nb:= 0;
  for i:= 1 to k do
  begin
		if (a[i] <= a[ha[1]]) then pusha(i)
    else pushb(i);

    if (na > i div 2) then
    begin
    	temp:= ha[1];
      popa(1);
      pushb(temp);
    end
    else
    	if (na < i div 2) then
      begin
      	temp:= hb[1];
        popb(1);
        pusha(temp);
      end;
	end;
  if (k mod 2 = 0) then mda[1]:= ha[1]
  else mda[1]:= hb[1];

  for i:= k + 1 to n do
  begin
		if (h[i - k] = 1) then popa(pos[i - k])
    else popb(pos[i - k]);

		if (a[i] <= a[ha[1]]) then pusha(i)
    else pushb(i);

    if (na > k div 2) then
    begin
    	temp:= ha[1];
      popa(1);
      pushb(temp);
    end
    else
    	if (na < k div 2) then
      begin
      	temp:= hb[1];
        popb(1);
        pusha(temp);
      end;

    if (k mod 2 = 0) then mda[i - k + 1]:= ha[1]
    else mda[i - k + 1]:= hb[1];
  end;
end;

procedure output;
var
	i: longint;
	res: int64;
begin
	res:= 0;
	for i:= 1 to n - k + 1 do
  	res:= res + a[mda[i]];

  writeln(fo,'Case #',test,': ',res);
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
