uses math;
const
	inputfile = '';
    outputfile = '';
    maxM = 2300;
    maxN = 12;
    maxC = 1000000000;
type
	room = record
		dir: array[1..4] of longint;
    end;
    state = record
    	x,y: longint;
    end;
var
	fi,fo: text;
    m,n,nheap: longint;
    a: array[0..maxM,0..maxN] of room;
    d: array[0..maxM,0..maxN] of longint;
    vs: array[0..maxM,0..maxN] of boolean;

    heap: array[1..maxM * maxN] of state;
    pos: array[0..maxM,0..maxN] of longint;

    dx: array[1..4] of longint = (-1,0,1,0);
    dy: array[1..4] of longint = (0,1,0,-1);


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
	i,j,k,num: longint;
begin
	readln(fi,m,n);
    for i:= 1 to 2 * m do
    	if (i mod 2 = 1) then
        begin
			for j:= 1 to n do
            begin
            	read(fi,num);
            	k:= i div 2;
            	a[k,j].dir[3]:= num;
                a[k+1,j].dir[1]:= num;
            end;
        end
        else
        begin
			for j:= 1 to n-1 do
            begin
				read(fi,num);
                k:= i div 2;
				a[k,j].dir[2]:= num;
                a[k,j+1].dir[4]:= num;
            end;
        end;
end;

procedure update(ps: longint);
var
	c,p,i,j: longint;
begin
	i:= heap[ps].x;
    j:= heap[ps].y;

    c:= ps;
    repeat
    	p:= c div 2;
        if (p = 0) or (d[i,j] >= d[heap[p].x,heap[p].y]) then break;

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
    for i:= 1 to n do
    begin
    	d[1,i]:= a[1,i].dir[1];
        inc(nheap);
        heap[nheap].x:= 1;
        heap[nheap].y:= i;
        pos[1,i]:= nheap;

        update(nheap);
    end;

    for i:= 2 to m do
    	for j:= 1 to n do
        begin
        	d[i,j]:= maxC;
            inc(nheap);
            heap[nheap].x:= i;
            heap[nheap].y:= j;
            pos[i,j]:= nheap;
        end;
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
        if (c < nheap) and (d[heap[c].x,heap[c].y] > d[heap[c+1].x,heap[c+1].y]) then inc(c);
		if (c > nheap) or (d[i,j] <= d[heap[c].x,heap[c].y]) then break;

        heap[p]:= heap[c];
        pos[heap[p].x,heap[p].y]:= p;
        p:= c;
    until FALSE;

    heap[p].x:= i;
    heap[p].y:= j;
    pos[i,j]:= p;
end;

procedure process;
var
	u,v,k,u1,v1: longint;
begin
	repeat
    	pop(u,v);
        if (u = m) and (v = n) then exit;
        if (nheap = 0) then exit;

        vs[u,v]:= true;

        for k:= 1 to 4 do
        begin
			u1:= u + dx[k];
            v1:= v + dy[k];
			
            if (u1 < 0) or (u1 > m) or (v1 < 0) or (v1 > n) then continue;

            if vs[u1,v1] then continue;

            if (d[u1,v1] > d[u,v] + a[u,v].dir[k]) then
            begin
				d[u1,v1]:= d[u,v] + a[u,v].dir[k];
                update(pos[u1,v1]);
            end;
        end;
    until FALSE;

end;

procedure output;
begin
	writeln(fo,d[m,n]);
end;


BEGIN
	openfile;
    input;
    init;
    process;
    output;
    closefile;
END.
