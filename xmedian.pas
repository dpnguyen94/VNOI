uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 200000 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n,na,nb: longint;
  ha,hb: array[1..maxN] of longint;


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
end;

procedure pusha(x: longint);
var
	c,p: longint;
begin
	inc(na);

  c:= na;
  repeat
  	p:= c div 2;
    if (p = 0) or (x <= ha[p]) then break;

    ha[c]:= ha[p];
    c:= p;
  until false;

	ha[c]:= x;
end;

function popa: longint;
var
	val,p,c: longint;
begin
	popa:= ha[1];

  val:= ha[na];
  dec(na);

  p:= 1;
  repeat
  	c:= p * 2;
    if (c < na) and (ha[c] < ha[c + 1]) then inc(c);
    if (c > na) or (val >= ha[c]) then break;

    ha[p]:= ha[c];
    p:= c;
  until false;

  ha[p]:= val;
end;

procedure pushb(x: longint);
var
	c,p: longint;
begin
	inc(nb);

  c:= nb;
  repeat
  	p:= c div 2;
    if (p = 0) or (x >= hb[p]) then break;

    hb[c]:= hb[p];
    c:= p;
  until false;

	hb[c]:= x;
end;

function popb: longint;
var
	val,p,c: longint;
begin
	popb:= hb[1];

  val:= hb[nb];
  dec(nb);

  p:= 1;
  repeat
  	c:= p * 2;
    if (c < nb) and (hb[c] > hb[c + 1]) then inc(c);
    if (c > nb) or (val <= hb[c]) then break;

    hb[p]:= hb[c];
    p:= c;
  until false;

  hb[p]:= val;
end;

procedure process;
var
	i,x,temp: longint;
begin
	na:= 0;
  nb:= 0;
	for i:= 1 to n do
	begin
  	readln(fi,x);
    if (x <= ha[1]) then pusha(x)
    else pushb(x);

    if (na < i div 2) then
    begin
    	temp:= popb;
      pusha(temp);
    end
    else
    	if (na > i div 2) then
      begin
      	temp:= popa;
        pushb(temp);
      end;

    if (i mod 2 = 0) then writeln(fo,ha[1])
    else writeln(fo,hb[1]);
  end;
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
