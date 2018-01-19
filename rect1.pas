{
ID: ndchiph1
PROG: rect1
LANG: PASCAL
}
uses math;
const
	maxR = 10000;

type
	rect = record
		x,y,u,v,colr: longint;
    end;

var
	fi,fo: text;
    a,b,n: longint;
    s: array[0..1,0..maxR] of rect;
    len: array[0..1] of longint;
    res: array[1..2500] of longint;
	
procedure input;
begin
	readln(fi,a,b,n);
end;


procedure add(var rec: rect; i,j,k,t,col: longint);
begin
	with rec do
    begin
		x:= i;
        y:= j;
        u:= k;
        v:= t;
        colr:= col;
    end;
end;

procedure process2(pr,ne: longint);
var
	r,p: rect;
    i: longint;
begin
	len[ne]:= 0;
    with r do
    begin
    	readln(fi,x,y,u,v,colr);

    	for i:= 1 to len[pr] do
        begin
			p:= s[pr,i];

            if (u < p.x) or (x > p.u) or (v < p.y) or (y > p.v) then
            begin
            	inc(len[ne]);
            	s[ne,len[ne]]:= p;
                continue;
            end;


            if (x > p.x) then
            begin
            	inc(len[ne]);
                add(s[ne,len[ne]],p.x,max(y,p.y),x,p.v,p.colr);
            end;

            if (y > p.y) then
            begin
            	inc(len[ne]);
                add(s[ne,len[ne]],p.x,p.y,min(u,p.u),y,p.colr);
            end;

            if (u < p.u) then
            begin
            	inc(len[ne]);
                add(s[ne,len[ne]],u,p.y,p.u,min(v,p.v),p.colr);
            end;

            if (v < p.v) then
            begin
            	inc(len[ne]);
                add(s[ne,len[ne]],max(x,p.x),v,p.u,p.v,p.colr);
            end;
        end;
    end;

    inc(len[ne]);
    s[ne,len[ne]]:= r;
end;

procedure process;
var
	p: rect;
	i,k: longint;
begin
	len[0]:= 1; add(s[0,1],0,0,a,b,1);

    for i:= 0 to n-1 do process2(i mod 2, 1 - i mod 2);

    k:= n mod 2;
    for i:= 1 to len[k] do
    begin
    	p:= s[k,i];
        res[p.colr]:= res[p.colr] + (p.u - p.x) * (p.v - p.y);
    end;

    for i:= 1 to 2500 do
    	if (res[i] > 0) then writeln(fo,i,' ',res[i]);
end;


begin
	assign(fi,'rect1.in'); reset(fi);
    assign(fo,'rect1.out'); rewrite(fo);
	//
    input;
    process;
    //
    close(fi);
    close(fo);
end.
