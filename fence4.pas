{
ID: ndchiph1
PROG: fence4
LANG: PASCAL
}
uses math;
const
	maxN = 210;
type
	point = record
    	x,y: longint;
    end;

    segment = record
    	p1,p2: point;
    end;
var
	fi,fo: text;
    n,cnt: longint;
    po: point;
    seg: segment;
    valid: boolean;
    d,c: array[1..maxN] of longint;

    p: array[0..maxN] of point;
 	sm: array[1..maxN] of segment;

procedure input;
var
	i: longint;
begin
	readln(fi,n);
    readln(fi,po.x,po.y);
    for i:= 1 to n do readln(fi,p[i].x,p[i].y);

    //
    p[0]:= p[n];
    p[n+1]:= p[1];
    for i:= 1 to n do
    begin
		sm[i].p1:= p[i];
        sm[i].p2:= p[i+1];
    end;	
end;

procedure extract(p1,p2: point; var a,b,c: longint);
begin
	a:= p1.y - p2.y;
    b:= p2.x - p1.x;
    with p1 do c:= -(a*x + b*y);
end;

function compare(p1,p2: point): boolean;
begin
	compare:= (p1.x = p2.x) and (p1.y = p2.y);
end;

function intersect(sm1,sm2: segment): boolean;
var
	a1,b1,c1,a2,b2,c2,t1,t2: longint;
begin
	extract(sm1.p1,sm1.p2,a1,b1,c1);
    extract(sm2.p1,sm2.p2,a2,b2,c2);

    with sm1 do
    	t1:= (p1.x*a2 + p1.y*b2 + c2) * (p2.x*a2 + p2.y*b2 + c2);

    with sm2 do
	  	t2:= (p1.x*a1 + p1.y*b1 + c1) * (p2.x*a1 + p2.y*b1 + c1);

    if (t1 = 0) and (t2 = 0) then
    	with sm1 do
   	 	begin
			if compare(p1,sm2.p1) or compare(p1,sm2.p2)
        		or compare(p2,sm2.p1) or compare(p2,sm2.p2) then exit(true);
            exit(false);
    	end;

    if (t1 > 0) or (t2 > 0) then exit(false);
    exit(true);
end;

function vector(p0,p1,p2,p3: point): boolean;
var
	a,b,c,t: longint;
begin
	extract(p1,p2,a,b,c);
    t:= p0.x*a + p0.y*b + c;
    if (t = 0) then exit(true);

    extract(p0,p3,a,b,c);
	t:= (p1.x*a + p1.y*b + c) * (p2.x*a + p2.y*b + c);
    if (t >= 0) then exit(false);

    extract(p0,p1,a,b,c);
	t:= (p3.x*a + p3.y*b + c) * (p2.x*a + p2.y*b + c);
	
    if (t <= 0) then exit(false);
    exit(true);
end;

procedure update(i: longint);
begin
	inc(cnt);
    d[cnt]:= i;
    c[cnt]:= i+1;
    if (c[cnt] = n+1) then c[cnt]:= 1;
end;

procedure process;
var
	i,j,k1,k2: longint;	
begin
	valid:= true;

	for i:= 1 to n do
    begin
    	k1:= 0;
    	for j:= 1 to n do
        	if (i <> j) and (intersect(sm[i],sm[j])) then inc(k1);
        if (k1 > 2) then
		begin
        	valid:= false;
            exit;
        end;		
    end;

    //
    cnt:= 0;
    for i:= 1 to n do
    begin
		seg.p1:= po; 		
        seg.p2:= p[i];

        k1:= 0;
        for j:= 1 to n do
        	if (i <> j) and (intersect(seg,sm[j])) then inc(k1);

        seg.p1:= po;
        seg.p2:= p[i+1];

        k2:= 0;
        for j:= 1 to n do
        	if (i <> j) and (intersect(seg,sm[j])) then inc(k2);

        if (k1 > 1) and (k2 > 1) then continue;

        if (k1 = 1) then
        begin
            if not vector(p[i],po,p[i+1],p[i-1]) then update(i);
            continue;
        end;
		
        if (k2 = 1) then
        begin
        	if (i = n) then k1:= 2
            else k1:= i+2;
        	if not vector(p[i+1],po,p[i],p[k1]) then update(i);
        end;
    end;
end;

procedure swap(var x,y: longint);
var
	z: longint;
begin
	z:= x; x:= y; y:= z;
end;

procedure wp(i: longint);
begin
	write(fo,p[i].x,' ',p[i].y);
end;

procedure output;
var
	i,j: longint;
begin
	if not valid then
    	writeln(fo,'NOFENCE');

    if (cnt > 0) then writeln(fo,cnt);

    //sort1;
    for i:= 1 to cnt do
    	if (d[i] > c[i]) then swap(d[i],c[i]);

    //sort2;
    for i:= 1 to cnt-1 do
    	for j:= i+1 to cnt do
        	if (c[i] > c[j]) or ((c[i] = c[j]) and (d[i] > d[j])) then
            begin
            	swap(d[i],d[j]);
                swap(c[i],c[j]);
            end;

    for i:= 1 to cnt do
    begin
    	wp(d[i]);
        write(fo,' ');
        wp(c[i]);
        writeln(fo);
    end;
end;


begin
	assign(fi,'fence4.in'); reset(fi);
    assign(fo,'fence4.out'); rewrite(fo);
    //
    input;
    process;
    output;
    //
    close(fi);
    close(fo);
end.
