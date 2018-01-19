{
ID: ndchiph1
PROG: range
LANG: PASCAL
}
uses math;
const
	maxN = 300;
var
	fi,fo: text;
	f: array[0..maxN,0..maxN] of longint;
	res: array[2..maxN] of longint;
    n: longint;


procedure process;
var
	i,j,k: longint;
    c: char;
begin
	readln(fi,n);
	for i:= 1 to n do
    begin
    	for j:= 1 to n do
        begin
			read(fi,c);
        	if (c = '1') then f[i,j]:= min(f[i-1,j-1], min(f[i,j-1],f[i-1,j])) + 1;
            if (f[i,j] >= 2) then
            	for k:= 2 to f[i,j] do inc(res[k]);
        end;
        readln(fi);
    end;
end;

procedure output;
var
	i: longint;
begin
	for i:= 2 to maxN do
    	if (res[i] > 0) then writeln(fo,i,' ',res[i]);
end;

begin
	assign(fi,'range.in1'); reset(fi);
    assign(fo,'range.out'); rewrite(fo);
	//
    process;
    output;
    //
    close(fi);
    close(fo);
end.
