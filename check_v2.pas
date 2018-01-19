{
ID: ndchiph1
PROG: checker
LANG: PASCAL
}

uses math;
const	MAX = 30;
var	
	fi,fo: text;
    n,res,res1: longint;
    a: array[1..MAX] of boolean;
    b: array[2..2*MAX] of boolean;
    c: array[1-MAX..MAX-1] of boolean;
	d: array[1..MAX] of integer;


procedure init;
begin
	fillchar(a,sizeof(a),true);
    fillchar(b,sizeof(b),true);
    fillchar(c,sizeof(c),true);
end;

procedure attempt2(i: integer);
var 	j,t: integer;
begin
	if (i = 1) then t:= n div 2
    else t:= n;
    //
    for j:= 1 to t do
    	if (a[j]) and (b[i+j]) and (c[i-j]) then
        begin
        	d[i]:= j;
            //
            if (i = n) then inc(res)
            else
            begin
            	a[j]:= false; b[i+j]:= false; c[i-j]:= false;
                attempt2(i+1);	
                a[j]:= true; b[i+j]:= true; c[i-j]:= true;
            end;
        end;
end;

procedure process;
var 	j: integer;
begin
    init;
    //
    res:= 0;
    attempt2(1);
    res:= res * 2;
    //
	if (n mod 2 = 1) then
    begin
    	j:= n div 2 + 1;
        a[j]:= false; b[1+j]:= false; c[1-j]:= false;
        attempt2(2);
    end;
    //
    writeln(fo,res);
end;

procedure printres;
var	i: integer;
begin
	inc(res);

  	for i:= 1 to n-1 do write(fo,d[i],' ');
  	write(fo,d[n]);
   	writeln(fo);

    if (res = 3) then
    begin
    	process;
        close(fi); close(fo);
        halt;
    end;
end;

procedure attempt1(i: integer);
var 	j: integer;
begin
    for j:= 1 to n do
    	if (a[j]) and (b[i+j]) and (c[i-j]) then
        begin
        	d[i]:= j;
            //
            if (i = n) then printres
            else
            begin
            	a[j]:= false; b[i+j]:= false; c[i-j]:= false;
                attempt1(i+1);	
                a[j]:= true; b[i+j]:= true; c[i-j]:= true;
            end;
        end;
end;



begin
	assign(fi,'checker.in'); reset(fi);
    assign(fo,'checker.out'); rewrite(fo);
    //
    readln(fi,n);
    init;
    attempt1(1);
    //
    close(fi);
    close(fo);
end.
