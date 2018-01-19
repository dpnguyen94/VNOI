uses math;
const
    maxN = 100010;

//type
var fi,fo: text;
    n: longint;
    a,f: array[0..maxN] of longint;

procedure input;
var     i: longint;
begin
    readln(fi,n);
    for i:= n downto 1 do read(fi,a[i]);
end;

procedure process;
var i,le,ri,k,mid,res: longint;
begin
    a[0]:= -maxlongint;

    k:= 0;
    for i:= 1 to n do
    begin
        le:= 0; ri:= k;
        while (le <= ri) do
        begin
            mid:= (le+ri) div 2;
            if (a[i] > a[f[mid]]) then
            begin
                le:= mid+1;
                res:= mid;
            end else ri:= mid-1;
        end;
        f[res+1]:= i;
        if (res + 1 > k) then k:= res + 1;
    end;

    writeln(fo,k);
end;

begin
    assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
    //
    input;
    process;
	//
    close(fi);
    close(fo);
end.
