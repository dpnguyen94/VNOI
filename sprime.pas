{
ID: ndchiph1	
PROG: sprime
LANG: PASCAL
}

uses math;
var	
	fi,fo: text;
	num: array[0..5] of longint = (1,2,3,5,7,9);
    a: array[0..8] of longint;
    n: integer;
    sprime: longint;

procedure print;
var	i: integer;
begin
	for i:= 1 to n do write(fo,a[i]);
    writeln(fo);
end;

function isprime(x: longint): boolean;
var	i: longint;
begin
	if (x = 2) then exit(true);
    for i:= 2 to trunc(sqrt(x))+1 do
		if (x mod i = 0) then exit(false);

    //
    exit(true);
end;



procedure attempt(i: integer);
var	j,t: integer;
begin
	if (i > n) then
    begin
    	print;
        exit;
    end;

    //
	if (i = 1) then t:= 1
    else t:= 0;

    //
    for j:= t to 5 do
    begin
    	if (isprime(sprime*10+num[j])) then
        begin
        	a[i]:= num[j];
            sprime:= sprime*10+num[j];
            attempt(i+1);
            sprime:= sprime div 10;
        end;
    end;
end;


procedure process;
begin
	a[0]:= 0;
    sprime:= 0;
    attempt(1);
end;

begin
	assign(fi,'sprime.in'); reset(fi);
    assign(fo,'sprime.out'); rewrite(fo);
    //
	readln(fi,n);
    process;
    //
    close(fi);
    close(fo);
end.