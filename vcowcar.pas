uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 50010;
//type

var
	fi,fo: text;
    n,m,d,l: longint;
    s: array[1..maxN] of longint;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i: longint;
begin
	readln(fi,n,m,d,l);
    for i:= 1 to n do
    	readln(fi,s[i]);
end;

procedure sort(le,ri: longint);
var
	i,j,z,t: longint;
begin
	if (le >= ri) then exit;
    i:= le; j:= ri;
    t:= s[(i+j) div 2];

    repeat
    	while (s[i] < t) do inc(i);
        while (s[j] > t) do dec(j);

        if (i <= j) then
        begin
            z:= s[i]; s[i]:= s[j]; s[j]:= z;
            inc(i); dec(j);
        end;
    until i > j;

    sort(le,j);
    sort(i,ri);
end;

function canplace(x: longint): boolean;
var
	i,cnt,t,smin: longint;
begin
    t:= n - x + 1;
    cnt:= 0;
    smin:= maxlongint;

	for i:= t to n do
    begin
    	smin:= min(smin,s[i] - d * (cnt div m));
        inc(cnt);
    end;

    if (smin < l) then canplace:= false
    else canplace:= true;
end;

procedure process;
var
	le,ri,mid,res: longint;
begin
	sort(1,n);

	le:= 0; ri:= n;
    while (le <= ri) do
    begin
    	mid:= (le + ri) div 2;
		if canplace(mid) then
        begin
        	res:= mid;
            le:= mid + 1;
        end
        else ri:= mid - 1;
    end;

    writeln(fo,res);
end;

procedure output;
begin
end;

procedure closefile;
begin
	close(fi);
    close(fo);
end;


begin
	openfile;
    input;
    process;
    output;
    closefile;
end.
