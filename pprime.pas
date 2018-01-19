{
ID: ndchiph1	
PROG: pprime
LANG: PASCAL
}

uses math;
var	
	fi,fo: text;
    a,b,len: longint;
    d: array[1..10] of longint;



function isprime(x: longint): boolean;
var	i: longint;
begin
	if (x = 1) then exit(false);
	if (x = 2) then exit(true);
    for i:= 2 to trunc(sqrt(x)) do
		if (x mod i = 0) then exit(false);

    exit(true);
end;


procedure process1;
var 	i,j,len1,s: longint;
begin
	len1:= len div 2 + 1;
    i:= len1;
    dec(len1);

    //
    while (len1 > 0) do
    begin
    	inc(i);
        d[i]:= d[len1];
        dec(len1);
    end;
	
    //
    s:= 0;
    for j:= 1 to i do s:= s*10 + d[j];
    if (s < a) then exit;
    if (s > b) then begin close(fi); close(fo); halt; end;

    //
    if isprime(s) then writeln(fo,s);
end;

procedure process2;
var  	i,j,len1,s: longint;
begin
	len1:= len div 2;
    i:= len1;

    //
    while (len1 > 0) do
    begin
    	inc(i);
        d[i]:= d[len1];
        dec(len1);
    end;

    //
    s:= 0;
    for j:= 1 to i do s:= s*10 + d[j];
    if (s < a) then exit;
    if (s > b) then begin close(fi); close(fo); halt; end;

    //
    if isprime(s) then writeln(fo,s);
end;




procedure attempt(i: integer);
var 	j,t: integer;
begin
	if (len mod 2 = 1) then
		if (i > len div 2 + 1) then
		begin
        	process1;
            exit;
        end;

    if (len mod 2 = 0) then
    	if (i > len div 2) then
        begin
        	process2;
			exit;
        end;
    //
    if (i = 1) then t:= 1
    else t:= 0;

    //
    for j:= t to 9 do
    begin
		d[i]:= j;
        attempt(i+1);
    end;
end;


procedure process;
var 	t,lena,lenb: longint;
begin
	t:= a;
    lena:= 0;
    while (t > 0) do
    begin
    	inc(lena);
        t:= t div 10;
    end;

    t:= b;
    lenb:= 0;
    while (t > 0) do
    begin
    	inc(lenb);
		t:= t div 10;
    end;
	
    for len:= lena to lenb do attempt(1);
end;


begin
	assign(fi,'pprime.in'); reset(fi);
    assign(fo,'pprime.out'); rewrite(fo);
    //
    readln(fi,a,b);
    process;
    //
    close(fi);
    close(fo);
end.
