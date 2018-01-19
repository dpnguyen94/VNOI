uses math;
var
	fi,fo: text;
    n,i,j: longint;
    f: array[0..4000] of int64;

begin

	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);


    f[0]:= 1;
    readln(fi,n);
    for i:= 1 to n-1 do
    	for j:= n downto 0 do
        	inc(f[j+i],f[j]);

    writeln(fo,f[n]);

    close(fi);
    close(fo);
end.