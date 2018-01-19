{
ID: ndchiph1
PROG: zerosum
LANG: PASCAL
}
uses math;
//const
	
//type

var
	fi,fo: text;
    a: array[0..10] of longint;
	val: array[1..3] of longint = (10,1,-1);
    exp: string[3] = ' +-';
    n: longint;


procedure input;
begin
	readln(fi,n);
end;


procedure equal;
var 	res,i,t: longint;
begin
	res:= 0;
	
    //
    for i:= 0 to n-1 do
    begin
    	if (a[i] = 1) then continue;
        if (a[i+1] = 1) then
        begin
        	t:= ((i+1) * 10 + i+2) * val[a[i]];
            inc(res,t);
        end else
        begin
        	t:= (i+1) * val[a[i]];
            inc(res,t);
        end;
    end;
	
    //
    if (res = 0) then
    begin
		for i:= 1 to n-1 do write(fo,i,exp[a[i]]);
        write(fo,n);
        writeln(fo);
    end;
end;


procedure attempt(i: longint);
var	j,t: longint;
begin
	if (i = n) then
    begin
		equal;
        exit;
    end;
	
    //
    if (a[i-1] = 1) then t:= 2
    else t:= 1;

    for j:= t to 3 do
    begin
		a[i]:= j;
        attempt(i+1);
    end;
end;



procedure process;
begin
	a[0]:= 2;
	attempt(1);
end;


begin
	assign(fi,'zerosum.in'); reset(fi);
    assign(fo,'zerosum.out'); rewrite(fo);
	//
    input;
    process;
    //
    close(fi);
    close(fo);
end.
