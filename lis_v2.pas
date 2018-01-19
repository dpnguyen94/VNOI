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
    for i:= 1 to n do read(fi,a[i]);
end;

procedure process;
var i,le,ri,k,mid,m: longint;
begin
    a[0]:= -maxlongint;

    k:= 0;
    for i:= 1 to n do
    begin
        le:= 0; ri:= k;
        while (le <= ri) do
        begin
            mid:= (le+ri) div 2;
            if (a[f[mid]] < a[i]) then
            begin
                le:= mid+1;
                m:= mid;
            end else ri:= mid-1;
        end;
        f[m+1]:= i;
        if (m + 1 > k) then k:= m + 1;
    end;

    writeln(fo,k);
end;

begin
    assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);

    input;
    process;

    close(fi);
    close(fo);
end.
