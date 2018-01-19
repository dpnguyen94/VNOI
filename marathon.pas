{
ID: ndchiph1
PROG: marathon
LANG: PASCAL
}
uses math;
const
	inputfile = 'marathon.in';
    outputfile = 'marathon.out';
    maxN = 5010;
//type

var
	fi,fo: text;
    n: longint;
    h,m,s: array[0..maxN] of longint;

procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure closefile;
begin
	close(fi);
    close(fo);
end;

procedure input;
var
	i: longint;
begin
	readln(fi,n);
    for i:= 1 to n do
    	readln(fi,h[i],m[i],s[i]);
end;

procedure swap(var x,y: longint);
var
	z: longint;
begin
	z:= x;
    x:= y;
    y:= z;
end;

procedure sort(le,ri: longint);
var
	i,j,mid,h1,m1,s1: longint;
begin
	if (le >= ri) then exit;
    i:= le; j:= ri;
    mid:= (le + ri) div 2;
    h1:= h[mid];
    m1:= m[mid];
    s1:= s[mid];

    repeat
    	while (h[i] < h1) or ((h[i] = h1) and (m[i] < m1))
        	or ((h[i] = h1) and (m[i] = m1) and (s[i] < s1)) do inc(i);
        while (h[j] > h1) or ((h[j] = h1) and (m[j] > m1))
        	or ((h[j] = h1) and (m[j] = m1) and (s[j] > s1)) do dec(j);
		
        if (i <= j) then
        begin
        	swap(h[i],h[j]);
            swap(m[i],m[j]);
            swap(s[i],s[j]);

            inc(i); dec(j);
        end;
    until i > j;

    sort(le,j);
    sort(i,ri);
end;

procedure process;
begin
	sort(1,n);
end;

procedure output;
var
	i: longint;
begin
	for i:= 1 to n do
    	writeln(fo,h[i],' ',m[i],' ',s[i]);
end;


BEGIN
	openfile;
    input;
    process;
    output;
    closefile;
END.
