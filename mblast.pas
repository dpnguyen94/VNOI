uses math;
const
    maxL = 2010;

var
    fi,fo: text;
    f: array[0..maxL,0..maxL] of longint;
    k: longint;
    s1,s2: ansistring;

procedure input;
begin
    readln(fi,s1);
    readln(fi,s2);
    readln(fi,k);
end;

procedure process;
var
    i,j,len1,len2: longint;
begin
    len1:= length(s1);
    len2:= length(s2);

    for i:= 1 to len2 do f[0,i]:= k * i;
    for i:= 1 to len1 do f[i,0]:= k * i;

    for i:= 1 to len1 do
        for j:= 1 to len2 do
        	f[i,j]:= min(f[i-1,j-1] + abs(ord(s1[i])-ord(s2[j])),
        			min(f[i-1,j],f[i,j-1])+k);

    writeln(fo,f[len1,len2]);
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
