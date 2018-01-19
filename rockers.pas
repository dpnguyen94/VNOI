{
ID: ndchiph1
PROG: rockers
LANG: PASCAL
}
uses math;
const
	maxN = 21;
//type

var                                	
	fi,fo: text;
    n,t,m,res: longint;
    a,so: array[1..maxN] of longint;

procedure input;
var
	i: longint;
begin
	readln(fi,n,t,m);
    for i:= 1 to n do read(fi,so[i]);
end;

procedure solve;
var
	t1,m1,s,i: longint;
begin
	t1:= t; m1:= m;
    s:= 0;

    for i:= 1 to n do
    	if (a[i] = 1) then
        begin
        	inc(s);

            if (m1 = 0) then exit;

			if (so[i] <= t1) then dec(t1,so[i])
			else
            	if (m1 > 1) then
                begin
                	dec(m1);
                    t1:= t;

                    if (so[i] <= t1) then dec(t1,so[i])
                    else exit;
                end
                else exit;
		end;

	if (s > res) then res:= s;
end;

procedure attempt(i: longint);
var
	j: longint;
begin
	if (i > n) then
    begin
    	solve;
        exit;
    end;

    for j:= 0 to 1 do
    begin
		a[i]:= j;
		attempt(i+1);
    end;
end;

procedure process;
begin
	res:= 0;
	attempt(1);
end;

procedure output;
begin
	writeln(fo,res);
end;

begin
	assign(fi,'rockers.in'); reset(fi);
    assign(fo,'rockers.out'); rewrite(fo);
	//
    input;
    process;
    output;
    //
    close(fi);
    close(fo);
end.
