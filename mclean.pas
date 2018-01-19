uses math;
const
	inputfile = '';
    outputfile = '';
    LM = 21;
type
	dirty = record
    	x,y: longint;
    end;
    queue = record
    	x,y: longint;
    end;
var
	fi,fo: text;
    w,h,ndt,res: longint;
	a: array[0..LM,0..LM] of longint;
	d: array[0..LM,0..LM,0..LM,0..LM] of longint;
    dt: array[1..11] of dirty;
    c: array[1..11,1..11] of longint;
    free: array[1..LM] of boolean;
    b: array[1..11] of longint;

	qu: array[1..LM * LM] of queue;
	dq,cq: longint;
    vs: array[0..LM,0..LM] of boolean;

	dx: array[1..4] of longint = (-1,1,0,0);
    dy: array[1..4] of longint = (0,0,-1,1);


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
    ch: char;
begin
	fillchar(a,sizeof(a),0);

    ndt:= 1;
    for i:= 1 to h do
    begin
    	for j:= 1 to w do
        begin
        	read(fi,ch);

			if (ch = '*') then
            begin
            	inc(ndt);
                dt[ndt].x:= i;
                dt[ndt].y:= j;
            end;

            if (ch = 'o') then
            begin
                dt[1].x:= i;
                dt[1].y:= j;
            end;

            if (ch = 'x') then
            	a[i,j]:= 1;
        end;
        readln(fi);
    end;
end;

procedure BFS(dt: dirty);
var
	x1,y1,x2,y2,k: longint;
begin
	fillchar(vs,sizeof(vs),false);

	dq:= 1; cq:= 1;
	qu[1].x:= dt.x;
    qu[1].y:= dt.y;
    vs[qu[1].x,qu[1].y]:= true;

    while (dq <= cq) do
    begin
		x1:= qu[dq].x;
        y1:= qu[dq].y;
        inc(dq);

        for k:= 1 to 4 do
        begin	
        	x2:= x1 + dx[k];
            y2:= y1 + dy[k];

            if (x2 < 1) or (x2 > h) or (y2 < 1) or (y2 > w)
            	or (vs[x2,y2]) or (a[x2,y2] = 1) then continue;

            inc(cq);
            qu[cq].x:= x2;
            qu[cq].y:= y2;
            vs[x2,y2]:= true;

            d[dt.x,dt.y,x2,y2]:= d[dt.x,dt.y,x1,y1] + 1;
        end;
    end;
end;

procedure solve;
var
	i,tmp: longint;	
begin
	tmp:= c[1,b[1]];
	for i:= 1 to ndt-2 do
		tmp:= tmp + c[b[i],b[i+1]];

    if (tmp < res) then res:= tmp;
end;

procedure attempt(i: longint);
var
	j: longint;
begin
	if (i = ndt) then
    begin
    	solve;
        exit;
    end;
	
    for j:= 2 to ndt do
    	if free[j] then
        begin
        	b[i]:= j;
          free[j]:= false;
            attempt(i+1);
            free[j]:= true;
        end;
end;

procedure process;
var
	i,j,x1,y1,x2,y2,t: longint;	
begin
	fillchar(d,sizeof(d),0);
    for i:= 1 to ndt do
    	BFS(dt[i]);

	res:= 0;
	fillchar(c,sizeof(c),0);
    for i:= 1 to ndt do
    	for j:= 1 to ndt do
    	begin
        	if (i = j) then continue;

			x1:= dt[i].x;
            y1:= dt[i].y;
			x2:= dt[j].x;
            y2:= dt[j].y;

			if (d[x1,y1,x2,y2] = 0) then
            begin
            	res:= -1;
                exit;
            end;

            t:= d[x1,y1,x2,y2];
            c[i,j]:= t;
            c[j,i]:= t;						
        end;
end;

procedure output;
begin
	if (res = -1) then
    begin
    	writeln(fo,-1);
        exit;
    end;

	res:= maxlongint;
    fillchar(free,sizeof(free),true);
    attempt(1);

    writeln(fo,res);	
end;


begin
	openfile;
    while TRUE do
    begin
    	readln(fi,w,h);
        if (w = 0) then break;

        //
    	input;
    	process;
    	output;
    end;
    closefile;
end.
