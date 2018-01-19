uses math;
const
	inputfile = '';
  outputfile = '';
	LM = 1 shl 16 + 10;
type
	arr = array[1..4,1..4] of longint;
var
	fi,fo: text;
  a,b: arr;
	qu,d: array[1..LM] of longint;
  vs: array[0..LM] of boolean;
  dq,cq,t: longint;

  dx: array[1..4] of longint = (0,-1,0,1);
  dy: array[1..4] of longint = (-1,0,1,0);


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
  c: char;
begin
	for i:= 1 to 4 do
  begin
  	for j:= 1 to 4 do
    begin
    	read(fi,c);
      a[i,j]:= ord(c) - ord('0');
    end;
    readln(fi);
  end;

  for i:= 1 to 4 do
  begin
  	for j:= 1 to 4 do
    begin
    	read(fi,c);
      b[i,j]:= ord(c) - ord('0');
    end;
    readln(fi);
  end;
end;

function getbit(num,i: longint): longint;
begin
	getbit:= (num shr i) and 1;
end;

function transtonum(x: arr): longint;
var
	i,j,tmp,cnt: longint;
begin
	tmp:= 0;
	cnt:= 0;
	for i:= 1 to 4 do
  	for j:= 1 to 4 do
    begin
			inc(cnt);
      if (x[i,j] = 1) then
      	tmp:= tmp + 1 shl (cnt - 1);
    end;

  exit(tmp);
end;

procedure transtoarr(num: longint; var x: arr);
var
	i,j,cnt: longint;
begin
	cnt:= 0;
	for i:= 1 to 4 do
  	for j:= 1 to 4 do
    begin
    	inc(cnt);
			x[i,j]:= getbit(num,cnt - 1);
    end;
end;

procedure trans(a: arr; var b: arr; i,j,k: longint);
var
	x,y: longint;
begin
	b:= a;
	x:= i + dx[k];
  y:= j + dy[k];

  if (x < 1) or (x > 4)
  	or (y < 1) or (y > 4) then exit;

  if (a[x,y] = 0) then
  begin
  	b[i,j]:= 0;
    b[x,y]:= 1;
  end;
end;

procedure push(val: longint);
begin
	inc(cq);
  qu[cq]:= val;
end;

function pop: longint;
begin
	pop:= qu[dq];
  inc(dq);
end;

procedure process;
var
	u,v,i,j,k: longint;
begin
	v:= transtonum(a);
  t:= transtonum(b);

  dq:= 1; cq:= 0;	
  push(v);
  d[v]:= 0;
  vs[v]:= true;

  while (dq <= cq) do
  begin
		u:= pop;
    transtoarr(u,a);

		for i:= 1 to 4 do
    	for j:= 1 to 4 do
        if (a[i,j] = 1) then
					for k:= 1 to 4 do
          begin
          	trans(a,b,i,j,k);
					  v:= transtonum(b);

            if vs[v] then continue;

            push(v);
            d[v]:= d[u] + 1;
            vs[v]:= true;

            if vs[t] then exit;
          end;
  end;
end;

procedure output;
begin
	writeln(fo,d[t]);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
