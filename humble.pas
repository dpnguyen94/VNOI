{
ID: ndchiph1
PROG: humble
LANG: PASCAL
}
uses math;
const
    maxN = 100010;
    maxK = 110;
	
//type
	
var
	fi,fo: text;
	n,k: longint;
   	cur,p: array[0..maxK] of longint;
    h: array[0..maxN] of longint;

procedure input;
var	i,j,t: longint;
begin
	readln(fi,k,n);
    for i:= 1 to k do read(fi,p[i]);
	
    for i:= 1 to k-1 do
    	for j:= i+1 to k do
        	if (p[i] > p[j]) then
            begin
            	t:= p[i];
                p[i]:= p[j];
                p[j]:= t;
            end;
end;


procedure process;
var		i,j,t,tmp,min: longint;
begin
    h[0]:= 1;
    for i:= 1 to k do cur[i]:= 0;

    t:= 1;
	while (t <= n) do
    begin
    	min:= maxlongint;
        for i:= 1 to k do
        begin
        	tmp:= h[cur[i]] * p[i];
        	if (tmp < min) then min:= tmp;
        end;

        for i:= 1 to k do
        	if (h[cur[i]] * p[i] = min) then inc(cur[i]);

        h[t]:= min;
        inc(t);
    end;	

    writeln(fo,h[n]);
end;


begin
	assign(fi,'humble.in'); reset(fi);
    assign(fo,'humble.out'); rewrite(fo);
	//
    input;
    process;
    //
    close(fi);
    close(fo);
end.
