{
ID: ndchiph1
PROG: maze1
LANG: PASCAL
}
uses math;
const
	maxH = 210;
    maxW = 100;
    maxS = 100 * 50;
var
	fi,fo: text;

    c: array[1..maxH] of string[100];

	qx,qy: array[1..maxS] of longint;
    a,val: array[0..maxH,0..maxW] of longint;

    dx,dy: array[1..2] of longint;
    offx: array[0..3] of longint = (0,-1,0,1);
    offy: array[0..3] of longint = (-1,0,1,0);
	
    w,h,dq,cq: longint;

procedure input;
var 	i,j,k,t,cnt: longint;
begin
	readln(fi,w,h);
	for i:= 1 to 2*h+1 do
    begin
    	readln(fi,c[i]);
        k:= i div 2;
        if (i mod 2 = 1) then
        begin       	
            for j:= 1 to 2*w+1 do
            	if (j mod 2 = 0) then
                begin
                	if (c[i][j] = ' ') then continue;
                	t:= j div 2;
                	inc(a[k,t],8);
				    inc(a[k+1,t],2);
                end;
        end else
        begin
        	for j:= 1 to 2*w+1 do
            	if (j mod 2 = 1) then
                begin
                	if (c[i][j] <> '|') then continue;
					t:= j div 2;
                    inc(a[k,t],4);
                    inc(a[k,t+1]);
                end;
        end;
    end;

    //
    cnt:= 0;
    k:= 2*h + 1;
    for i:= 1 to 2*w+1 do
    	if (i mod 2 = 0) then
        begin
        	if (c[1][i] = ' ') then
            begin
				inc(cnt);
                dx[cnt]:= 1;
                dy[cnt]:= i div 2;
                inc(a[dx[cnt],dy[cnt]],2);
            end;

            if (c[k][i] = ' ') then
            begin
            	inc(cnt);
                dx[cnt]:= h;
                dy[cnt]:= i div 2;
                inc(a[dx[cnt],dy[cnt]],8);
            end;
        end;

    k:= 2*w + 1;
    for i:= 1 to 2*h+1 do
    	if (i mod 2 = 0) then
        begin
        	if (c[i][1] = ' ') then
            begin
				inc(cnt);
                dx[cnt]:= i div 2;
                dy[cnt]:= 1;
                inc(a[dx[cnt],dy[cnt]]);
            end;

            if (c[i][k] <> '|') then
            begin
            	inc(cnt);
                dx[cnt]:= i div 2;
                dy[cnt]:= w;
                inc(a[dx[cnt],dy[cnt]],4);
            end;
        end;
	
    dq:= 1; cq:= 0;
    inc(cq); qx[cq]:= dx[1]; qy[cq]:= dy[1];
    inc(cq); qx[cq]:= dx[2]; qy[cq]:= dy[2];
    val[dx[1],dy[1]]:= 1;
    val[dx[2],dy[2]]:= 1;
end;


procedure process;
var		x,y,x1,y1,i: longint;
begin
	while (dq <= cq) do
    begin
    	x:= qx[dq]; y:= qy[dq];
        inc(dq);

		for i:= 0 to 3 do
        	if ((a[x,y] shr i) and 1 = 0) then
            begin
            	x1:= x + offx[i]; y1:= y + offy[i];
                if val[x1,y1] > 0 then continue;
				
                inc(cq);
                qx[cq]:= x1;
                qy[cq]:= y1;
                val[x1,y1]:= val[x,y] + 1;
            end;
    end;

    writeln(fo,val[qx[cq],qy[cq]]);
end;


begin
	assign(fi,'maze1.in'); reset(fi);
    assign(fo,'maze1.out'); rewrite(fo);
	//
    input;
    process;
    //
    close(fi);
    close(fo);
end.
