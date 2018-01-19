uses math;
const
     maxN = 1010;
     maxM = 11;

var
    fi,fo: text;
    n,m: longint;
    a,pos: array[1..maxM,1..maxN] of longint;
    f: array[0..maxN] of longint;


procedure input;
var
    i,j: longint;
begin
    readln(fi,n,m);
    for i:= 1 to m do
        for j:= 1 to n do
        begin
            read(fi,a[i,j]);
            pos[i,a[i,j]]:= j;
        end;
end;

procedure process;
var
    i,j,k,res: longint;
    valid: boolean;
begin
    for i:= 1 to n do f[i]:= 1;

    for i:= 1 to n do
    begin
        for j:= i-1 downto 1 do
        begin
            valid:= true;

            for k:= 2 to m do
                if (pos[k,a[1,i]] < pos[k,a[1,j]]) then
                begin
                    valid:= false;
                    break;
                end;

            if (valid) then
            	if (f[j] + 1 > f[i]) then
                	f[i]:= f[j] + 1;
        end;
    end;

    res:= 0;
    for i:= 1 to n do
    	if (f[i] > res) then
        	res:= f[i];

    //
    writeln(fo,res);
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
