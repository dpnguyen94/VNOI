uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 100010;
//type
	
var
	fi,fo: text;
	ntest,test,n: longint;
    l,w,f: array[0..maxN] of longint;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i: longint;
begin
	readln(fi,n);
    for i:= 1 to n do read(fi,l[i],w[i]);
end;

procedure sort(le,ri: longint);
var
	i,j,t,t1,t2,z: longint;
begin
	if (le >= ri) then exit;
    i:= le; j:= ri;
    t:= (i + j) div 2;
    t1:= l[t];
    t2:= w[t];

    repeat
    	while (l[i] > t1) or ((l[i] = t1) and (w[i] < t2)) do inc(i);
        while (l[j] < t1) or ((l[j] = t1) and (w[j] > t2)) do dec(j);

        if (i <= j) then
        begin
        	z:= l[i]; l[i]:= l[j]; l[j]:= z;
            z:= w[i]; w[i]:= w[j]; w[j]:= z;

            inc(i); dec(j);
        end;

    until i >= j;

    sort(le,j);
    sort(i,ri);
end;

procedure process;
var
	le,ri,res,mid,i,k: longint;
begin
    sort(1,n);

    //
    w[0]:= -maxlongint;
	k:= 0;
	for i:= 1 to n do
    begin
		le:= 0; ri:= k;
        while (le <= ri) do
        begin
        	mid:= (le + ri) div 2;
			if (w[i] >= w[f[mid]]) then
            begin
				res:= mid;
        		le:= mid + 1;
            end else ri:= mid - 1;
        end;

        f[res + 1]:= i;
        if (res + 1 > k) then k:= res + 1;
    end;

    writeln(fo,k);
end;

procedure output;
begin
end;

procedure closefile;
begin
	close(fi);
    close(fo);
end;


begin
	openfile;
    input;
    process;
    output;
    closefile;
end.
