{
ID: ndchiph1
PROG: frac1
LANG: PASCAL
}
uses math;
const
	LM = 30000;

type
	mang1 = array[1..LM] of integer;
    mang2 = array[0..LM] of real;

var
	fi,fo: text;
 	n,m: integer;
    a,b: mang1;
    c: mang2;

procedure input;
begin
	readln(fi,n);
end;


function gcd(x,y: integer): integer;
begin
	if (x = 0) or (y = 0) then exit(x+y);
    //
    if (x > y) then exit(gcd(y,x mod y))
    else exit(gcd(x,y mod x));

end;

procedure init;
var	i,j,t: integer;
begin
	m:= 0;
	for i:= 2 to n do
    	for j:= 1 to i-1 do
        begin
        	inc(m);
            t:= gcd(i,j);
			a[m]:= j div t;
        	b[m]:= i div t;
            c[m]:= a[m]/b[m];
        end;
end;


procedure swap1(var x,y: integer);
var z: integer;
begin
	z:= x; x:= y; y:= z;
end;

procedure swap2(var x,y: real);
var z: real;
begin
	z:= x; x:= y; y:= z;
end;

procedure sort(le,ri: integer);
var	i,j: integer;
	t: real;
begin
	if (le >= ri) then exit;
    i:= le; j:= ri;
    t:= c[(i+j) div 2];

    //
    repeat
    	while (c[i] < t) do inc(i);
        while (c[j] > t) do dec(j);

        if (i <= j) then
        begin
        	if (i < j) then
            	if (c[i] > c[j]) or (a[i] > a[j]) then
                begin
            		swap1(a[i],a[j]);
			    	swap1(b[i],b[j]);
                	swap2(c[i],c[j]);
                end;
           	inc(i); dec(j);
        end;

    until i >= j;

    sort(le,j);
    sort(i,ri);
end;


procedure process;
begin
	sort(1,m);
end;

procedure output;
var 	i: integer;
begin
	writeln(fo,'0/1');
	c[0]:= 0;
    for i:= 1 to m do
		if (c[i] > c[i-1]) then writeln(fo,a[i],'/',b[i]);
    writeln(fo,'1/1');
end;

begin
	assign(fi,'frac1.in'); reset(fi);
    assign(fo,'frac1.out'); rewrite(fo);
    //
    input;
    init;
    process;
    output;
    //
    close(fi);
    close(fo);
end.
