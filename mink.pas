uses math;
const
	maxN = 20000;
//type

var                                	
	fi,fo: text;
    n,k,ntest,test: longint;
    a,st,res: array[0..maxN] of longint;

procedure input;
var
	i: longint;
begin
	readln(fi,n,k);
    for i:= 1 to n do read(fi,a[i]);
end;

procedure build_stack;
var
	first,last,i,t: longint;
begin	
	first:= 1; last:= 0;
    for i:= 1 to k do
    begin
    	while (first <= last) and (a[i] < a[st[last]]) do dec(last);
        inc(last); st[last]:= i;
    	res[1]:= a[st[first]];
    end;

    for i:= k+1 to n do
    begin
    	t:= i-k;
    	if (st[first] = t) then inc(first);
        while (first <= last) and (a[i] < a[st[last]]) do dec(last);
        inc(last); st[last]:= i;
    	
        inc(t);
        res[t]:= a[st[first]];
    end;

    for i:= 1 to n-k+1 do write(fo,res[i],' ');
    writeln(fo);
end;


begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
	//
    readln(fi,ntest);
    for test:= 1 to ntest do
    begin
    	input;
    	build_stack;
    end;
    //
    close(fi);
    close(fo);
end.
