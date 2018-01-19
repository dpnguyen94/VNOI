uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 100010;
//type

var
	fi,fo: text;
    n,m: longint;
    a,s,neo,b,d,f: array[0..maxN] of longint;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i: longint;
begin
	readln(fi,n);
    for i:= 1 to n do
    begin
    	read(fi,a[i]);
        s[i]:= s[i-1] + a[i];
    end;

	readln(fi,m);
    for i:= 1 to m do
    	readln(fi,b[i],d[i]);
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
	i,j,t: longint;
begin
	if (le >= ri) then exit;
    i:= le; j:= ri;
    t:= b[(i+j) div 2];

    repeat
    	while (b[i] < t) do inc(i);
        while (b[j] > t) do dec(j);

        if (i <= j) then
        begin
        	swap(b[i],b[j]);
            swap(d[i],d[j]);

            inc(i); dec(j);
        end;

    until i >= j;

    sort(le,j);
    sort(i,ri);
end;

procedure init;
var
	i,j: longint;
begin
	sort(1,m);

    for i:= 1 to m do
    	neo[b[i]]:= i;
end;

procedure DP;
var
	i,j,last: longint;
begin
	last:= 0;
	for i:= 1 to n do
    	if (neo[i] <> 0) then
        begin
        	j:= i - d[neo[i]];
        	if (last <= j) then
            	f[i]:= f[j] + (s[i] - s[j]);

            //
            last:= i;
        end
        else
        begin
        	f[i]:= f[i-1];

			j:= i - d[neo[last]];
			if (last >= j + 1) and (b[neo[last]-1] <= j) then
            	f[i]:= max(f[i],f[j] + (s[i] - s[j]))
        end;
end;

procedure output;
begin
	writeln(fo,f[n]);
end;

procedure closefile;
begin
	close(fi);
    close(fo);
end;


begin
	openfile;
    input;
    init;
    DP;
    output;
    closefile;
end.
