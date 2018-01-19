{
ID: ndchiph1
PROG: subset
LANG: PASCAL
}
uses math;
const
	LM = 400;
var
	fi,fo: text;
    f: array[0..LM] of int64;
    n,sum: longint;


procedure process;
var 	i,j,maxval: longint;
begin
	fillchar(f,sizeof(f),0);
    f[0]:= 1;

    //
    maxval:= 0;
    for i:= 1 to n do
    begin
        for j:= maxval downto 0 do
        	if (f[j] > 0) and (j+i <= sum) then
            	inc(f[j+i],f[j]);
		if (maxval + i <= sum) then inc(maxval,i);
    end;

    //
    writeln(fo,f[sum] div 2);
end;


begin
	assign(fi,'subset.in'); reset(fi);
    assign(fo,'subset.out'); rewrite(fo);
	//
    readln(fi,n);
    sum:= n * (n+1) div 2;
    if (sum mod 2 = 0) then
    begin
    	sum:= sum div 2;
    	process;
    end else writeln(fo,0);
    //
    close(fi);
    close(fo);
end.
