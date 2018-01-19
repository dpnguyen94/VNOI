uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 20000 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n,nheap: longint;
  heap: array[1..maxN] of int64;


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

procedure push(x: int64);
var
	p,c: longint;
begin
	inc(nheap);

  c:= nheap;
  repeat
  	p:= c div 2;
    if (p = 0) or (x >= heap[p]) then break;	

    heap[c]:= heap[p];
    c:= p;
  until false;
	
  heap[c]:= x;	
end;

function pop: int64;
var
	x: int64;
  c,p: longint;
begin
	pop:= heap[1];

	x:= heap[nheap];
  dec(nheap);

  p:= 1;
  repeat
  	c:= p * 2;
    if (c < nheap) and (heap[c] > heap[c + 1]) then inc(c);
    if (c > nheap) or (x <= heap[c]) then break;

    heap[p]:= heap[c];
    p:= c;
  until false;

  heap[p]:= x;
end;

procedure process;
var
	i: longint;
  x,min1,min2,res: int64;
begin
	nheap:= 0;
	for i:= 1 to n do
  begin
  	read(fi,x);
    push(x);
  end;

  res:= 0;
  for i:= 1 to n - 1 do
  begin
  	min1:= pop;
    min2:= pop;

    res:= res + min1 + min2;
    push(min1 + min2);
  end;

  writeln(fo,res);
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
