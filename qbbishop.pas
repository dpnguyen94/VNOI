uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 210;
type
	queue = record
    	x,y: longint;
    end;
var
	fi,fo: text;
    n,m,p,q,s,t: longint;
	a: array[0..maxN,0..maxN] of boolean;
    d: array[0..maxN,0..maxN] of longint;
	
    qu: array[1..maxN * maxN] of queue;
    dq,cq: longint;

    dx: array[1..4] of longint = (-1,-1,1,1);
    dy: array[1..4] of longint = (-1,1,-1,1);

procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i,u,v: longint;		
begin
	readln(fi,n,m,p,q,s,t);
    for i:= 1 to m do
    begin
    	readln(fi,u,v);
        a[u,v]:= true;
    end;
end;

procedure process;
var
	p1,q1,p2,q2,i,k: longint;
begin
	dq:= 1; cq:= 1;
    qu[1].x:= p;
    qu[1].y:= q;
    d[p,q]:= 1;


    while (dq <= cq) do
    begin
    	p1:= qu[dq].x;
        q1:= qu[dq].y;
		inc(dq);

	    for i:= 1 to 4 do
        begin
        	for k:= 1 to n do
	        begin
            	p2:= p1 + dx[i] * k;
                q2:= q1 + dy[i] * k;

                if (p2 < 1) or (p2 > n) or (q2 < 1) or (q2 > n)
                	or (a[p2,q2]) then break;
                if (d[p2,q2] > 0) then continue;
				
                inc(cq);
                qu[cq].x:= p2;
                qu[cq].y:= q2;
                d[p2,q2]:= d[p1,q1] + 1;
                if (d[s,t] > 0) then exit;
            end;
        end;
    end;
end;

procedure output;
begin
	writeln(fo,d[s,t] - 1);
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
