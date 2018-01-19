var	
	fi,fo: text;
    a: array[1..31] of longint;
    n,l,cnt: longint;

procedure valid;
var
	i,count: longint;
begin
	count:= 0;
	for i:= 1 to n do
    	if (a[i] = 1) then inc(count);

    for i:= 1 to n do write(fo,a[i]);

    if (count <= l) then
    begin
    	inc(cnt);
    	write(fo,' ',cnt);
    end;

    writeln(fo);
end;

procedure attempt(i: longint);
var
	j: longint;
begin
	if (i > n) then
    begin
    	valid;
        exit;
    end;

    for j:= 0 to 1 do
    begin
		a[i]:= j;
		attempt(i+1);
    end;
end;

begin
	assign(fi,''); reset(fi);
    assign(fo,'kimbits.out1'); rewrite(fo);
	
	readln(fi,n,l);
    cnt:= 0;
	attempt(1);
    writeln(fo,cnt);

    close(fi);
    close(fo);
end.
