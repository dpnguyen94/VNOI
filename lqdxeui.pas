uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 100000 + 10;
//type

var
	fi,fo: text;
  n,st,sum1,sum2: longint;
	x,y,c1,h,f: array[1..maxN] of longint;
  a,c: array[1..2 * maxN] of longint;
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

procedure input;
var
	i,u,v: longint;
begin
	readln(fi,n,st);
  for i:= 1 to n-1 do
  begin
  	readln(fi,x[i],y[i],c1[i]);
		inc(h[x[i]]);
    inc(h[y[i]]);
    inc(sum1,c1[i]);
  end;

  for i:= 2 to n+1 do
  	h[i]:= h[i-1] + h[i];

  for i:= 1 to n-1 do
  begin
  	u:= x[i];
    v:= y[i];

    a[h[u]]:= v;
    a[h[v]]:= u;
    c[h[u]]:= c1[i];
    c[h[v]]:= c1[i];

    dec(h[u]);
    dec(h[v]);
  end;
end;

procedure visit(u: longint);
var
	i,v,tmp,max1,max2: longint;
begin
	vs[u]:= true;
  max1:= 0;
  max2:= 0;

  for i:= h[u]+1 to h[u+1] do
  begin
		v:= a[i];

    if not vs[v] then
    begin
			visit(v);
      tmp:= f[v] + c[i];

      if (tmp > max1) then
      begin
      	max2:= max1;
        max1:= tmp;
      end
      else
      	if (tmp > max2) then
        	max2:= tmp;
    end;
  end;

  f[u]:= max1;
  sum2:= max(sum2,max1 + max2);
end;

procedure process;
begin
	fillchar(vs,sizeof(vs),false);
	sum2:= 0;
	visit(1);
end;

procedure output;
begin
	writeln(fo,2 * sum1 - sum2);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
