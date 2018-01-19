const
     inputfile = '';
     outputfile = '';
     maxN = 5010;
     maxM = 20010;
     maxC = 1000000000;
//type

var
   fi,fo: text;
   n,m,nheap: longint;
   k,x,y,l: array[1..maxM] of longint;
   a,c: array[1..2 * maxM] of longint;
   h,d: array[1..maxN] of longint;
   w: array[1..maxN] of int64;

   heap,pos: array[1..maxN] of longint;
   vs: array[1..maxN] of boolean;


procedure openfile;
begin
     assign(fi,inputfile); reset(fi);
     assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
   i,u,v: longint;
begin
     readln(fi,n,m);
     for i:= 1 to m do
     begin
          readln(fi,k[i],x[i],y[i],l[i]);
          if (k[i] = 1) then inc(h[x[i]])
          else
          begin
               inc(h[x[i]]);
               inc(h[y[i]]);
          end;
     end;

     for i:= 2 to n+1 do
         h[i]:= h[i-1] + h[i];

     for i:= 1 to m do
     begin
          u:= x[i];
          v:= y[i];

          if (k[i] = 1) then
          begin
               a[h[u]]:= v;
               c[h[u]]:= l[i];

               dec(h[u]);
          end
          else
          begin
               a[h[u]]:= v;
               a[h[v]]:= u;
               c[h[u]]:= l[i];
               c[h[v]]:= l[i];

               dec(h[u]);
               dec(h[v]);
          end;
     end;
end;


procedure init;
var
   i: longint;
begin
     d[1]:= 0;
     nheap:= n;
     heap[1]:= 1;
     pos[1]:= 1;
     w[1]:= 1;

     for i:= 2 to n do
     begin
          d[i]:= maxC;
          heap[i]:= i;
          pos[i]:= i;
     end;
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
           if (c < nheap) and (d[heap[c]] > d[heap[c+1]]) then inc(c);
           if (c > nheap) or (d[i] <= d[heap[c]]) then break;

           heap[p]:= heap[c];
           pos[heap[p]]:= p;
           p:= c;
     until FALSE;

     heap[p]:= i;
     pos[i]:= p;
end;


procedure update(x: longint);
var
   i,c,p: longint;
begin
     i:= heap[x];

     c:= x;
     repeat
           p:= c div 2;
           if (p = 0) or (d[i] >= d[heap[p]]) then break;

           heap[c]:= heap[p];
           pos[heap[c]]:= c;
           c:= p;
     until FALSE;

     heap[c]:= i;
     pos[i]:= c;
end;


procedure process;
var
   i,u,v: longint;
begin
     repeat
           u:= pop;
           if (nheap = 0) then exit;
           vs[u]:= true;

           for i:= h[u]+1 to h[u+1] do
           begin
                v:= a[i];

                if not vs[v] and (d[v] > d[u] + c[i]) then
                begin
                     d[v]:= d[u] + c[i];
                     w[v]:= w[u];

                     update(pos[v]);
                end
                else
                    if (d[v] = d[u] + c[i]) then w[v]:= w[v] + w[u];
           end;
     until FALSE;
end;


procedure output;
begin
     writeln(fo,d[n],' ',w[n]);
end;

procedure closefile;
begin
     close(fi);
     close(fo);
end;

begin
     openfile;
     input;
     init;
     process;
     output;
     closefile;
end.
