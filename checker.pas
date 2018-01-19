{
ID: ndchiph1
PROG: checker
LANG: PASCAL
}

uses math;
const	MAX = 13;
var
	fi,fo: text;
    d: array[1..MAX] of integer;
    a: array[1..MAX] of boolean;
    b: array[2..2*MAX] of boolean;
    c: array[1-MAX..MAX-1] of boolean;
    n,res: longint;

procedure print;
var    	i: integer;
		first: boolean;
begin
	inc(res);
	if (res > 3) then exit;

    //
    for i:= 1 to n-1 do write(fo,d[i],' ');
    write(fo,d[n]);
    writeln(fo);
end;

procedure attempt(i: integer);
var 	j: integer;
begin
	for j:= 1 to n do
    	if a[j] and b[i+j] and c[i-j] then
        begin
        	d[i]:= j;
            if i = n then print
            else
            begin
            	a[j]:= false; b[i+j]:= false; c[i-j]:= false;
                attempt(i+1);
                a[j]:= true; b[i+j]:= true; c[i-j]:= true;
            end;
        end;
end;

procedure process;
begin
	fillchar(a,sizeof(a),true);
    fillchar(b,sizeof(b),true);
    fillchar(c,sizeof(c),true);

    //
    res:= 0;
    attempt(1);
	
    writeln(fo,res);
end;


begin
	assign(fi,'checker.in'); reset(fi);
    assign(fo,'checker.out'); rewrite(fo);
    //
    readln(fi,n);
    process;
    //
    close(fi);
    close(fo);
end.
