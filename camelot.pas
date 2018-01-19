{
ID: ndchiph1
PROG: camelot
LANG: PASCAL
}
uses math;
const
	maxR = 41;
    maxC = 27;
	LM = maxR * maxC;
type
	knights = record
		x,y: longint;
    end;
var                                	
	fi,fo: text;
    rows,cols,res,cnt,nt: longint;
    kx,ky: longint;
    kn: array[1..LM] of knights;
    king,total: array[0..maxR,0..maxC] of longint;
    d: array[0..maxR,0..maxC,0..maxR,0..maxC] of longint;

    val,xt,yt: array[1..LM] of longint;

    qx,qy: array[1..LM] of longint;
    dq,cq,x1,x2,y1,y2,k: longint;
    vs: array[0..maxR,0..maxC] of boolean;

procedure input;       	
var                   	
	i: longint;
    c: char;
    str: ansistring;
begin
	readln(fi,rows,cols);
	readln(fi,c,kx);
    ky:= ord(c) - ord('A') + 1;

    //
    cnt:= 0;
    while not eof(fi) do
    begin
    	while not eoln(fi) do
        begin
        	read(fi,c);
            if (c >= 'A') and (c <= 'Z') then
            begin
            	inc(cnt);
			    kn[cnt].y:= ord(c) - ord('A') + 1;
                read(fi,kn[cnt].x);
            end;
        end;
        readln(fi);
    end;
end;

procedure BFS1(i,j: longint);
var
	dx: array[1..8] of longint = (2,1,-1,-2,-2,-1,1,2);
    dy: array[1..8] of longint = (1,2,2,1,-1,-2,-2,-1);
begin
	fillchar(vs,sizeof(vs),false);

	dq:= 1; cq:= 1;
    qx[1]:= i;
    qy[1]:= j;
    vs[i,j]:= true;
    d[i,j,i,j]:= 0;

    while (dq <= cq) do
    begin
    	x1:= qx[dq];
        y1:= qy[dq];
        inc(dq);

        for k:= 1 to 8 do
        begin
        	x2:= x1 + dx[k];
            y2:= y1 + dy[k];

            if (x2 < 1) or (x2 > rows) or
            (y2 < 1) or (y2 > cols) or (vs[x2,y2]) then continue;

            inc(cq);
            qx[cq]:= x2;
            qy[cq]:= y2;
            vs[x2,y2]:= true;

            d[i,j,x2,y2]:= d[i,j,x1,y1] + 1;
        end;
    end;
end;

procedure BFS2;
var
	dx: array[1..8] of longint = (1,1,0,-1,-1,-1,0,1);
    dy: array[1..8] of longint = (0,1,1,1,0,-1,-1,-1);
begin
	fillchar(vs,sizeof(vs),false);

    dq:= 1; cq:= 1;
    qx[1]:= kx;
    qy[1]:= ky;
    vs[kx,ky]:= true;

	while (dq <= cq) do
    begin
    	x1:= qx[dq];
        y1:= qy[dq];
        inc(dq);

        for k:= 1 to 8 do
        begin
        	x2:= x1 + dx[k];
            y2:= y1 + dy[k];

            if (x2 < 1) or (x2 > rows) or
            (y2 < 1) or (y2 > cols) or (vs[x2,y2]) then continue;

            inc(cq);
            qx[cq]:= x2;
            qy[cq]:= y2;
            vs[x2,y2]:= true;

            king[x2,y2]:= king[x1,y1] + 1;
        end;
    end;
end;

procedure init;
var
	i,j,u,v,k: longint;
begin
	for i:= 1 to rows do
    	for j:= 1 to cols do
        	for u:= 1 to rows do
            	for v:= 1 to cols do
                	d[i,j,u,v]:= 1000000;
	
	for i:= 1 to rows do
    	for j:= 1 to cols do BFS1(i,j);

    BFS2;

    nt:= 0;
    for i:= 1 to rows do
    	for j:= 1 to cols do
        begin
        	for k:= 1 to cnt do
        		inc(total[i,j], d[kn[k].x,kn[k].y,i,j]);

            //
            inc(nt);
            val[nt]:= total[i,j];
            xt[nt]:= i;
            yt[nt]:= j;
        end;
end;

procedure sort;
var
	i,j,z: longint;
begin
	for i:= 1 to nt-1 do
    	for j:= i+1 to nt do
			if (val[i] > val[j]) then
            begin
         		z:= val[i]; val[i]:= val[j]; val[j]:= z;
                z:= xt[i]; xt[i]:= xt[j]; xt[j]:= z;
                z:= yt[i]; yt[i]:= yt[j]; yt[j]:= z;
            end;			
end;

procedure process;
var
	i,j,u,v,k,tt,t: longint;
begin
	if (cnt = 0) then
    begin
    	res:= 0;
        exit;
	end;


    sort;
    //
	res:= maxlongint;
    for tt:= 1 to nt do
    begin
        i:= xt[tt];
        j:= yt[tt];
        if (total[i,j] >= res) then break;

        for u:= 1 to rows do
        	for v:= 1 to cols do
            	for k:= 1 to cnt do
                begin
            		t:= total[i,j] - d[kn[k].x,kn[k].y,i,j]
                		+ d[kn[k].x,kn[k].y,u,v] + king[u,v] + d[u,v,i,j];

                    //
                    if (t < res) then res:= t;
                end;
    end;
end;

procedure output;
begin
	writeln(fo,res);
end;

begin
    assign(fi,'camelot.in'); reset(fi);
    assign(fo,'camelot.out'); rewrite(fo);
	//
    input;
    init;
    process;
    output;
    //
    close(fi);
    close(fo);
end.
