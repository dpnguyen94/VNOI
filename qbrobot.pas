uses math;
const
  inputfile = '';
  outputfile = '';
  maxN = 500 + 10;
  maxM = 30000 + 10;
  maxC = 10000 * maxM;
//type

var
  fi,fo: text;
  n,m: longint;
  x,y,t1,c1: array[1..maxM] of longint;
  h,k: array[1..maxN] of longint;
  a,t,c: array[1..2 * maxM] of longint;

  d,f1,f2,heap,pos: array[1..maxN] of longint;
  nheap: longint;
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
  readln(fi,n);
  for i:= 1 to n do
    read(fi,k[i]);

  readln(fi,m);
  for i:= 1 to m do
  begin
    readln(fi,u,v,t1[i],c1[i]);
    inc(h[u]);
    inc(h[v]);

    x[i]:= u;
    y[i]:= v;
  end;

  for i:= 2 to n + 1 do
    h[i]:= h[i - 1] + h[i];

  for i:= 1 to m do
  begin
    u:= x[i];
    v:= y[i];

    a[h[u]]:= v;
    a[h[v]]:= u;
    t[h[u]]:= t1[i];
    t[h[v]]:= t1[i];
    c[h[u]]:= c1[i];
    c[h[v]]:= c1[i];

    dec(h[u]);
    dec(h[v]);
  end;
end;

procedure init;
var
  i: longint;
begin
  d[1]:= 0;
  heap[1]:= 1;
  pos[1]:= 1;
  nheap:= n;

  for i:= 2 to n do
  begin
    d[i]:= maxC;
    heap[i]:= i;
    pos[i]:= i;
  end;

  fillchar(vs,sizeof(vs),false);
end;

procedure update(ps: longint);
var
  i,c,p: longint;
begin
  i:= heap[ps];

  c:= ps;
  repeat
    p:= c div 2;
    if (p = 0) or (d[i] >= d[heap[p]]) then break;

    heap[c]:= heap[p];
    pos[heap[c]]:= c;
    c:= p;
  until false;

  heap[c]:= i;
  pos[i]:= c;
end;

function pop: longint;
var
  i,p,c: longint;
begin
  pop:= heap[1];

  i:= heap[nheap];
  dec(nheap);

  p:= 1;
  repeat
    c:= p * 2;
    if (c < nheap) and (d[heap[c]] > d[heap[c + 1]]) then inc(c);
    if (c > nheap) or (d[i] <= d[heap[c]]) then break;

    heap[p]:= heap[c];
    pos[heap[p]]:= p;
    p:= c;
  until false;

  heap[p]:= i;
  pos[i]:= p;
end;

procedure dijkstra;
var
  i,u,v: longint;
begin
  repeat
    u:= pop;
    if (nheap = 0) then exit;
    vs[u]:= true;

    for i:= h[u] + 1 to h[u + 1] do
    begin
      v:= a[i];

      if not vs[v] and (d[v] > d[u] + t[i]) then
      begin
        d[v]:= d[u] + t[i];
        f1[v]:= max(f1[u],f2[u] + c[i]);

        if (k[v] = 0) then f2[v]:= f2[u] + c[i]
        else f2[v]:= 0;

        update(pos[v]);
      end
      else
      begin
        if (d[v] = d[u] + t[i]) then
        begin
          f1[v]:= min(f1[v],max(f1[u],f2[u] + c[i]));
          if (k[v] = 0) then f2[v]:= min(f2[v],f2[u] + c[i])
          else f2[v]:= 0;
        end;
      end;
    end;
  until false;
end;

procedure output;
begin
  writeln(fo,f1[n]);
end;


BEGIN
  openfile;
  input;
  init;
  dijkstra;
  output;
  closefile;
END.
