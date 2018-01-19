uses math;
const
	inputfile = 'fair.inp';
    outputfile = 'fair.out';
    LM = 110;
    maxC = 1000000;
type
	point = record
		x,y: longint;
    end;
var
	fi,fo: text;
    m,n,nheap: longint;
	a,d,pos: array[0..LM,0..LM] of longint;
	heap: array[0..LM * LM] of point;	
	vs: array[0..LM,0..LM] of boolean;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;


procedure input;
var
	i,j: longint;
begin
	readln(fi,m,n);
	for i:= 1 to m do
    	for j:= 1 to n do
        	read(fi,a[i,j]);
end;


procedure pop(var u,v: longint);
var
	p,c,i,j: longint;
begin
	u:= heap[1].x;
    v:= heap[1].y;

    i:= heap[nheap].x;
    j:= heap[nheap].y;
	dec(nheap);	
	
    p:= 1;
    repeat
		c:= p * 2;
		if (c < nheap) and
        	(d[heap[c+1].x,heap[c+1].y] < d[heap[c].x,heap[c].y]) then inc(c);
		if (c > nheap) or (d[heap[c].x,heap[c].y] >= d[i,j]) then break;		

        heap[p]:= heap[c];
        pos[heap[p].x,heap[p].y]:= p;
        p:= c;
    until FALSE;

    heap[p].x:= i;
    heap[p].y:= j;
    pos[i,j]:= p;
end;


procedure update(ps: longint);
var
	p,c,i,j: longint;	
begin
	i:= heap[ps].x;
    j:= heap[ps].y;

    c:= ps;
    repeat
    	p:= c div 2;
        if (p = 0) or (d[heap[p].x,heap[p].y] <= d[i,j]) then break;

        heap[c]:= heap[p];
        pos[heap[c].x,heap[c].y]:= c;
		c:= p;
    until FALSE;
	
    heap[c].x:= i;
    heap[c].y:= j;
    pos[i,j]:= c;
end;


procedure init;
var
	i,j: longint;
begin
	nheap:= 0;
	for i:= 1 to m do
    begin
    	d[i,1]:= a[i,1];

        inc(nheap);
        heap[nheap].x:= i;
        heap[nheap].y:= 1;
        pos[i,1]:= nheap;

		update(nheap);
    end;

	for i:= 1 to m do
    	for j:= 2 to n do
        begin
        	d[i,j]:= maxC;
			
            inc(nheap);
            heap[nheap].x:= i;
            heap[nheap].y:= j;
            pos[i,j]:= nheap;
        end;
end;


procedure Dijkstra;
var
	u,v,i,j,k: longint;
    dx: array[1..4] of longint = (-1,1,0,0);
    dy: array[1..4] of longint = (0,0,-1,1);
begin
	repeat
		pop(u,v);
		vs[u,v]:= true;
		if (nheap = 0) then break;

        for k:= 1 to 4 do
        begin
        	i:= u + dx[k];
            j:= v + dy[k];
	
    		if (i < 1) or (i > m)	
            	or (j < 1) or (j > n) or (vs[i,j]) then continue;

            if (d[i,j] > d[u,v] + a[i,j]) then
            begin
            	d[i,j]:= d[u,v] + a[i,j];

                update(pos[i,j]);
            end;
        end;						    	
    until FALSE;
end;


procedure output;
var
	i,res: longint;
begin
	res:= maxC;
    for i:= 1 to m do
    	if (d[i,n] < res) then res:= d[i,n];

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
    init;
    Dijkstra;
    output;
    closefile;
end.
