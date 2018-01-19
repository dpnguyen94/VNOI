uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 10010;
    maxM = 50010;
//type

var
	fi,fo: text;
    n,m,s: longint;
	a,x,y: array[0..maxM] of longint;
    h,qu,d: array[1..maxN] of longint;
    f: array[1..maxN] of longint;

    vs: array[1..maxN] of boolean;
    dq,cq: longint;

procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure sort(le,ri: longint);
var
	i,j,z,t,t1,t2: longint;
begin
	if (le >= ri) then exit;
    i:= le; j:= ri;
    t:= (le + ri) div 2;
    t1:= x[t];
    t2:= y[t];

    repeat
    	while (x[i] < t1) or ((x[i] = t1) and (y[i] < t2)) do inc(i);
        while (x[j] > t1) or ((x[j] = t1) and (y[j] > t2)) do dec(j);

		if (i <= j) then
        begin
        	z:= x[i]; x[i]:= x[j]; x[j]:= z;
            z:= y[i]; y[i]:= y[j]; y[j]:= z;

            inc(i); dec(j);
        end;

    until i >= j;
	
    sort(le,j);
    sort(i,ri);
end;

procedure input;
var
	i,u,v: longint;
begin
	readln(fi,n,m,s);
	for i:= 1 to m do
		readln(fi,x[i],y[i]);
	
    //
    sort(1,m);
    for i:= 1 to m do
    begin
    	if (x[i] = x[i-1]) and (y[i] = y[i-1]) then continue;

		inc(h[x[i]]);
    end;

    for i:= 2 to n+1 do
    	h[i]:= h[i-1] + h[i];

    for i:= 1 to m do
    begin
    	if (x[i] = x[i-1]) and (y[i] = y[i-1]) then continue;

        u:= x[i];
        v:= y[i];
        a[h[u]]:= v;
        dec(h[u]);
    end;
end;

procedure process;
var
	i,u,v: longint;
begin
	dq:= 1; cq:= 1;
	qu[1]:= s;
    f[s]:= 1;
    vs[s]:= true;

    while dq <= cq do
    begin
		u:= qu[dq];
        inc(dq);

        for i:= h[u]+1 to h[u+1] do
        begin
        	v:= a[i];
			
            if (not vs[v]) then
            begin
            	inc(cq);
                qu[cq]:= v;
                vs[v]:= true;

                d[v]:= d[u] + 1;
                f[v]:= f[u];
            end
            else
            	if (d[v] = d[u] + 1) then
                	inc(f[v]);
        end;		
    end;
end;

procedure output;
var
	i,res: longint;
begin
	res:= 0;
    for i:= 1 to n do
    	if (f[i] >= 2) then inc(res);

    writeln(fo,res);
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
