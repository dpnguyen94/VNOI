{
ID: ndchiph1	
PROG: packrec
LANG: PASCAL
}
uses math;
var	fi,fo: text;
	a,b,a1,b1,c: array[1..4] of integer;
    free: array[1..4] of boolean;

    res: integer;
    d: array[1..200] of boolean;

procedure input;
var	i: integer;
begin
	for i:= 1 to 4 do readln(fi,a[i],b[i]);
end;

procedure update(x, y: integer);
begin
    if (res > x*y) then begin
    	fillchar(d,sizeof(d),false);
    	res:= x*y;
    end;
	if (res = x*y) then d[min(x,y)]:= true;
end;

procedure case1;
var i,x,y: integer;
begin
	x:= 0; y:= 0;
    for i:=1 to 4 do begin
    	x:= x + a1[c[i]];
		if (y < b1[c[i]]) then y := b1[c[i]];
    end;
    update(x, y);
end;

procedure case2;
var	i,x,y: integer;	
begin
	x:= 0; y:= 0;
    for i:= 1 to 3 do
    begin
    	x:= x + a1[c[i]];
        if (y < b1[c[i]]) then y:= b1[c[i]];
    end;
    if (x < a1[c[4]]) then x:= a1[c[4]];
	y:= y + b1[c[4]];

    update(x,y);
end;

procedure case3;
var	i,x,y: integer;
begin
	x:= max(a1[c[1]]+a1[c[2]],a1[c[3]])+a1[c[4]];
    //
    y:= max(b1[c[1]],b1[c[2]]) + b1[c[3]];
    y:= max(y,b1[c[4]]);

    update(x,y);
end;

procedure case4;
var	i,x,y: integer;
begin
	x:= a1[c[1]] + max(a1[c[2]],a1[c[3]]) + a1[c[4]];
    y:= max(b1[c[1]],b1[c[4]]);
    y:= max(y,b1[c[2]]+b1[c[3]]);

    update(x,y);
end;

procedure case5;
begin
end;

procedure case6;
var	x,y: integer;
begin
	if (a1[c[3]] + a1[c[4]] > a1[c[1]] + a1[c[2]]) then exit;
    if (a1[c[3]] > a[c[1]]) or (b1[c[2]] < b1[c[1]]) then exit;
	x:= a1[c[1]] + a1[c[2]];
    y:= max(b1[c[1]] + b1[c[3]],b1[c[2]] + b1[c[4]]);

    update(x,y);
end;


procedure process2;
begin
	case1;
    case2;
    case3;
    case4;
    case5;
    case6;
end;



procedure process1;
var 	i,j: integer;
begin
	for i:= 0 to (1 shl 4) - 1 do
    begin
    	for j:= 1 to 4 do if ((i shr (j-1)) and 1) = 0  then
        begin
        	a1[j]:= a[j];
            b1[j]:= b[j];
        end
        else
        begin
        	a1[j]:= b[j];
            b1[j]:= a[j];
        end;

        //
        process2;
    end;	
end;


procedure attempt(i: integer);
var  	j: integer;
begin
	if (i > 4) then
    begin
    	process1;
        exit;
    end;

    for j:= 1 to 4 do
    	if free[j] then begin
        	c[i]:= j;
            free[j]:= false;
            attempt(i+1);
            free[j]:= true;
        end;
end;


procedure process;
var	i: integer;
begin
	res:= maxint;
    fillchar(free,sizeof(free),true);
    attempt(1);

    //
	writeln(fo,res);
    for i:= 1 to 200 do
    	if d[i] then writeln(fo,i,' ',res div i);
end;


begin
	assign(fi,'packrec.in'); reset(fi);
    assign(fo,'packrec.out'); rewrite(fo);

    input;
    process;

    close(fi);
    close(fo);
end.																																																															
