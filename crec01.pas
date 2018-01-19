uses math;
const
	LM = 1010;
//type

var                                	
	fi,fo: text;
    h,left: array[0..LM] of longint;
    f: array[0..LM] of int64;
    m,n: longint;
    res: int64;


procedure process;
var
	i,j: longint;
begin	
	for i:= 1 to n do
    	left[i]:= i-1;

    h[0]:= -1;
    h[n+1]:= -1;
    for i:= 1 to n do
    begin
    	j:= left[i];
        while (h[j] >= h[i]) do j:= left[j];
        left[i]:= j;

        f[i]:= (i - j) * h[i] + f[j];
        inc(res,f[i]);
    end;
end;

procedure input;
var
	s: ansistring;
    i,j: longint;
begin
	readln(fi,m,n);

    res:= 0;
    for i:= 1 to m do
    begin
		readln(fi,s);
        for j:= 1 to n do
        	if (s[j] = '1') then inc(h[j])
            else h[j]:= 0;
        process;
    end;
end;

begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
	//
    input;
    writeln(fo,res);
    //
    close(fi);
    close(fo);
end.
