uses math;
const
    maxN = 100010;

var fi,fo: text;
    n: longint;
    a,b,f1,f2,l,r: array[0..maxN] of longint;

procedure input;
var
	i: longint;
begin
    readln(fi,n);
    for i:= 1 to n do read(fi,a[i]);
    for i:= 1 to n do b[i]:= a[n-i+1];
end;

procedure process1;
var
	i,le,ri,k,mid,res: longint;
begin
    a[0]:= -maxlongint;

    k:= 0;
    for i:= 1 to n do
    begin
        le:= 0; ri:= k;
        while (le <= ri) do
        begin
            mid:= (le+ri) div 2;
            if (a[f1[mid]] < a[i]) then
            begin
                le:= mid+1;
                res:= mid;
            end else ri:= mid-1;
        end;

        //
        f1[res + 1]:= i;
        l[i]:= res + 1;
        if (res + 1 > k) then k:= res + 1;
    end;
end;

procedure process2;
var
	i,le,ri,k,mid,res: longint;
begin
	b[0]:= -maxlongint;

    k:= 0;
    for i:= 1 to n do
    begin
        le:= 0; ri:= k;
        while (le <= ri) do
        begin
            mid:= (le+ri) div 2;
            if (b[ f2[mid] ] < b[i]) then
            begin
                le:= mid+1;
                res:= mid;
            end else ri:= mid-1;
        end;

        //
        f2[res + 1]:= i;
        r[i]:= res + 1;
        if (res + 1 > k) then k:= res + 1;
    end;
end;

procedure output;
var
	i,t,res: longint;
begin
	res:= 0;
	for i:= 1 to n do
    begin
    	t:= min(l[i],r[n-i+1]) * 2 - 1;
        if (t > res) then res:= t;
    end;	

    writeln(fo,res);
end;

begin
    assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
    //
    input;
    process1;
    process2;
	output;
	//
    close(fi);
    close(fo);
end.
