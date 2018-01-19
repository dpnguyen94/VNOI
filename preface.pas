{
ID: ndchiph1
PROG: preface
LANG: PASCAL
}
uses math;
const
	MAX_N = 3500;
var
	fi,fo: text;
    a: array[1..MAX_N] of string;
    ronum: string = 'IVXLCDM';
    num: array[1..7] of longint = (1,5,10,50,100,500,1000);
    res: array[1..MAX_N] of longint;
    n: longint;


procedure input;
begin
	readln(fi,n);
end;

function trans1(x: longint): string;
var	i,j: longint;
	s: string;
begin
	if (x = 0) then exit('');
    //
	i:= 1;
    while (num[i] <= x) do inc(i);
    if (num[i] - x = 1) then exit('I' + ronum[i]);
	
    //
	s:= ronum[i-1];
	for j:= 1 to x-num[i-1] do s:= s + 'I';
    exit(s);
end;


function trans2(x: longint): string;
var 	i,j: longint;
	s: string;
begin
	if (x = 0) then exit('');
    //
    x:= x * 10;
    i:= 1;
	    while (num[i] <= x) do inc(i);
    if (num[i] - x = 10) then exit('X' + ronum[i]);

    //
    s:= ronum[i-1];
    for j:= 1 to (x-num[i-1]) div 10 do s:= s + 'X';
    exit(s);
end;


function trans3(x: longint): string;
var 	i,j: longint;
	s: string;
begin
	if (x = 0) then exit('');
    //
    x:= x * 100;
    i:= 1;
    while (num[i] <= x) do inc(i);
    if (num[i] - x = 100) then exit('C' + ronum[i]);

    //
    s:= ronum[i-1];
    for j:= 1 to (x - num[i-1]) div 100 do s:= s + 'C';
    exit(s);
end;
	

function trans4(x: longint): string;
begin
	if (x = 1) then exit('M');
    if (x = 2) then exit('MM');
    if (x = 3) then exit('MMM');
end;


procedure init;
var s: string;
	i,j,t: longint;
begin
	for i:= 1 to n do
    begin
    	a[i]:= '';
        j:= i; t:= 0;
        while (j > 0) do
        begin
        	inc(t);
			case t of
            	1: a[i]:= trans1(j mod 10) + a[i];
                2: a[i]:= trans2(j mod 10) + a[i];
                3: a[i]:= trans3(j mod 10) + a[i];	
                4: a[i]:= trans4(j mod 10) + a[i];
            end;
            j:= j div 10;
		end;
    end;
end;


procedure process;
var 	i,j: longint;
begin
	fillchar(res,sizeof(res),0);

	for i:= 1 to n do
    begin
    	for j:= 1 to length(a[i]) do
        begin
        	case a[i][j] of
            	'I': inc(res[1]);
                'V': inc(res[2]);
                'X': inc(res[3]);
                'L': inc(res[4]);
                'C': inc(res[5]);
                'D': inc(res[6]);
                'M': inc(res[7]);
            end;
        end;
    end;

	//
    for i:= 1 to n do
    	if (res[i] > 0) then writeln(fo,ronum[i],' ',res[i]);
end;



begin
	assign(fi,'preface.in'); reset(fi);
    assign(fo,'preface.out'); rewrite(fo);
	//
    input;
    init;
    process;
    //
    close(fi);
    close(fo);
end.
