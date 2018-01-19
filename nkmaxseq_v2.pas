uses math;
const
	inputfile = '';
    outputfile = '';
	maxN = 50010;
//type

var
	fi,fo: text;
    n,p,res1: longint;
    a,s,smin: array[0..maxN] of longint;


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
	readln(fi,n,p);

    for i:= 1 to n do
    begin
    	read(fi,a[i]);
        s[i]:= s[i-1] + a[i];

        smin[i]:= min(s[i],smin[i-1]);
    end;
end;


procedure process;
var
	i,le,ri,mid,res2: longint;
begin
	for i:= 1 to n do
    begin
    	res2:= -1;
    	le:= 0; ri:= i-1;
        while (le <= ri) do
		begin
        	mid:= (le + ri) div 2;
            if (s[i] - smin[mid] >= p) then
            begin
            	res2:= mid;
                ri:= mid - 1;
            end
            else le:= mid + 1;
        end;

        if (res2 <> -1) and (i - res2 > res1) then
        	res1:= i - res2;
    end;
end;


procedure output;
begin
	if (res1 = 0) then writeln(fo,-1)
	else writeln(fo,res1);
end;


begin
	openfile;
    input;
    process;
    output;
    closefile;
end.
