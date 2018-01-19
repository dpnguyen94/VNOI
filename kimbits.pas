{
ID: ndchiph1	
PROG: kimbits
LANG: PASCAL
}
uses math;
const
	maxN = 35;
var
	fi,fo: text;
	n,l: longint;
    s: int64;
    res: array[1..maxN] of longint;
    c: array[0..maxN,0..maxN] of int64;


procedure input;
begin
	readln(fi,n,l,s);	
end;

procedure init;
var
	i,j: longint;
begin
	//
	c[0,0]:= 1;
    for i:= 1 to 31 do
    begin
    	c[0,i]:= 1; c[i,i]:= 1;
    	for j:= 1 to i-1 do c[j,i]:= c[j,i-1] + c[j-1,i-1];
    end;

    //
    for i:= 1 to 31 do
   	 	for j:= 1 to i do
    		c[j,i]:= c[j,i] + c[j-1,i];

	//
    for i:= 0 to 31 do
    	for j:= i+1 to 31 do
        	c[j,i]:= c[i,i];
end;

procedure process;
var
	i,t: longint;
begin
	t:= n;
	while (t > 0) do
    begin
    	if (s > c[l,t-1]) then
        begin
            res[t]:= 1;
            dec(s,c[l,t-1]);
            dec(l);
        end;
        dec(t);
    end;

    for i:= n downto 1 do write(fo,res[i]);
    writeln(fo);
end;


begin
	assign(fi,'kimbits.in'); reset(fi);
    assign(fo,'kimbits.out'); rewrite(fo);
	//
    input;
    init;
    process;
    //
    close(fi);
    close(fo);
end.
