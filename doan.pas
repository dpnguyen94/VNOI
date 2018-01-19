uses math;
const
	maxN = 100010;
//type

var                                	
	fi,fo: text;
    n,a,b,res: longint;
    u,v: array[1..maxN] of longint;

procedure input;
var
	i: longint;	
begin
	readln(fi,n,a,b);
	for i:= 1 to n do readln(fi,u[i],v[i]);
end;

procedure sort(le,ri: longint);
var
	i,j,z,t,t1,t2: longint;
begin
	if (le >= ri) then exit;
	i:= le; j:= ri;
    t:= (i + j) div 2;
    t1:= u[t];
    t2:= v[t];

    repeat
    	while (u[i] < t1) or ((u[i] = t1) and (v[i] < t2)) do inc(i);
        while (u[j] > t1) or ((u[j] = t1) and (v[j] > t2)) do dec(j);

        if (i <= j) then
        begin
        	z:= u[i]; u[i]:= u[j]; u[j]:= z;
            z:= v[i]; v[i]:= v[j]; v[j]:= z;
            inc(i); dec(j);
        end;
    until i >= j;

    sort(le,j);
    sort(i,ri);
end;

procedure process;
var
	i,j,c,v_max: longint;
    update: boolean;
begin
	sort(1,n);
    res:= 0;

    //
    j:= 1; c:= a;
    while TRUE do
    begin
		update:= false;
    	v_max:= -maxlongint;
		for i:= j to n do
        begin                                            	
        	if (u[i] <= c) and (v[i] > v_max) then v_max:= v[i];
            if (u[i] > c) then break;
        end;
		
        j:= i;
        if (v_max > c) then
        begin
        	c:= v_max;
        	inc(res);
            update:= true;
        end;
		
        if (c >= b) then exit;

        if not update then
        begin
        	res:= -1;
            exit;
        end;
	end;
end;

procedure output;
begin
	writeln(fo,res);
end;


begin
	assign(fi,'doan.in1'); reset(fi);
    assign(fo,'doan.out'); rewrite(fo);
	//
    input;
	process;
    output;
    //
    close(fi);
    close(fo);
end.
