uses math;
const
	LM = 410;
//type

var                                	
	fi,fo: text;
    m,n: longint;
    res: int64;
    a: array[0..LM] of longint;
    s: array[0..LM] of ansistring;
    h,left: array[0..LM] of longint;
    f: array[0..LM] of int64;
    st: string = 'ABCDE';


procedure input;
var
	i: longint;
begin
	readln(fi,m,n);
    for i:= 1 to m do readln(fi,s[i]);
end;

function solve(s1,s2,s3: longint): int64;
var
	i,j,k: longint;
    t: int64;
begin
	fillchar(h,sizeof(h),0);
    fillchar(f,sizeof(f),0);
	
    t:= 0;
	for i:= 1 to m do
    begin
		for j:= 1 to n do
        	if (s[i][j] = st[s1]) or (s[i][j] = st[s2]) or (s[i][j] = st[s3]) then inc(h[j])
            else h[j]:= 0;
		
        //
        for j:= 1 to n do left[j]:= j-1;

        //
        h[0]:= -1; h[n+1]:= -1;
        for j:= 1 to n do
        begin
        	k:= left[j];
            while (h[k] >= h[j]) do k:= left[k];
            left[j]:= k;

            f[j]:= (j - k) * h[j] + f[k];
            inc(t,f[j]);
		end;
    end;

    exit(t);
end;

procedure update;
begin
	res:= res + solve(a[1],a[2],a[3]) - solve(a[1],a[1],a[2]) - solve(a[1],a[1],a[3])
    	- solve(a[2],a[2],a[3]) + solve(a[1],a[1],a[1]) + solve(a[2],a[2],a[2])
        + solve(a[3],a[3],a[3]);
end;

procedure attempt(i: longint);
var
	j: longint;
begin
	if (i > 3) then
    begin
    	update;
    	exit;
    end;

    //
    for j:= a[i-1] + 1 to i + 2 do
    begin
    	a[i]:= j;
        attempt(i+1);
    end;
end;

procedure process;
begin
	attempt(1);
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
