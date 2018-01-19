uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 20010;
//type

var
	fi,fo: text;
    n,k: longint;
    vp,vc,vt: int64;
    a,h,x,y,len,num,child: array[1..maxN] of longint;
    c,id: array[1..maxN] of int64;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i,u,v: longint;
begin
	readln(fi,n,k,vp,vc);
	vt:= vc - vp;

    //
	for i:= 1 to n-1 do
    begin
		readln(fi,x[i],y[i],len[i]);
		inc(h[x[i]]);
		inc(h[y[i]]);
    end;

    for i:= 2 to n+1 do
    	h[i]:= h[i-1] + h[i];

    for i:= 1 to n-1 do
    begin
    	u:= x[i];
        v:= y[i];

        //
        a[h[u]]:= v;
        a[h[v]]:= u;
        c[h[u]]:= len[i] * vt;
        c[h[v]]:= c[h[u]];
        id[h[u]]:= i;
        id[h[v]]:= i;

        //
        dec(h[u]);
        dec(h[v]);
    end;
end;

procedure visit(u: longint);
var
	i,v: longint;
begin
	child[u]:= 1;

    for i:= h[u]+1 to h[u+1] do
    begin
		v:= a[i];
		if (child[v] = 0) then
		begin
        	visit(v);
            num[i]:= child[v] * (n - child[v]);
            child[u]:= child[u] + child[v];
        end;	
    end;
end;

procedure sort(le,ri: longint);
var
	i,j: longint;
    z,t: int64;
begin
	if (le >= ri) then exit;
    i:= le; j:= ri;
    t:= c[(le + ri) div 2];

    repeat
    	while (c[i] > t) do inc(i);
        while (c[j] < t) do dec(j);

        if (i <= j) then
        begin
        	z:= c[i]; c[i]:= c[j]; c[j]:= z;
            z:= id[i]; id[i]:= id[j]; id[j]:= z;

            inc(i); dec(j);
        end;
    until i > j;	

    sort(le,j);
    sort(i,ri);
end;

procedure process;
var
	i: longint;
begin
	visit(1);

    //
    for i:= 1 to 2 * (n-1) do
    	if (num[i] = 0) then
        	c[i]:= low(int64)
    	else
        	c[i]:= c[i] * num[i];

    //
    sort(1,2 * (n-1));
end;

procedure output;
var
	i: longint;
begin
	for i:= 1 to k do
    	write(fo,id[i],' ');
end;

procedure closefile;
begin
	close(fi);
    close(fo);
end;


begin
	openfile;
    input;
    process;
    output;
    closefile;
end.
