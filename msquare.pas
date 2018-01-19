{
ID: ndchiph1
PROG: msquare
LANG: PASCAL
}
uses math;
const
	maxN = 50000;
    LM = 10;
type
	mang = array[1..LM] of longint;
var                             	
	fi,fo: text;
	a: mang;
    f: array[1..maxN] of mang;
    cnt,stat: longint;

    t1,t2,q: array[1..maxN] of longint;
    free: array[1..LM] of boolean;


procedure attempt(i: longint);
var
	j: longint;
begin
	if (i > 8) then
    begin
    	inc(cnt);
        for j:= 1 to 8 do f[cnt,j]:= a[j];
        exit;
    end;

    for j:= 1 to 8 do
		if (free[j]) then
        begin
			a[i]:= j;
            free[j]:= false;
            attempt(i+1);
            free[j]:= true;
        end;
end;

procedure init;
begin
    fillchar(free,sizeof(free),true);
    cnt:= 0;
	attempt(1);
end;

//
function compare(i: longint; a: mang): longint;
var
	j: longint;
begin
    for j:= 1 to 8 do
    begin
    	if (f[i,j] > a[j]) then exit(1);
	    if (f[i,j] < a[j]) then exit(-1);
    end;

    exit(0);
end;

function pos(a: mang): longint;
var
	le,ri,mid: longint;
begin
	le:= 1; ri:= cnt;
    while (le <= ri) do
    begin
    	mid:= (le + ri) div 2;
        if (compare(mid,a) = 0) then exit(mid);

        //
        if (compare(mid,a) = 1) then ri:= mid - 1
        else le:= mid + 1;
    end;
end;

procedure input;
var
	i: longint;
begin
	for i:= 1 to 8 do read(fi,a[i]);
    stat:= pos(a);
end;

//
procedure case1;
var
	i,z,t: longint;
begin
	for i:= 1 to 4 do
    begin
    	t:= 9 - i;
        z:= a[i];
        a[i]:= a[t];
        a[t]:= z;
    end;
end;

procedure case2;
var
	z1,z2,i: longint;
begin
	z1:= a[4]; z2:= a[5];
    for i:= 4 downto 2 do
    begin
    	a[i]:= a[i-1];
        a[9-i]:= a[9-i+1];
    end;

    a[1]:= z1; a[8]:= z2;
end;

procedure case3;
var
	z: longint;
begin
    z:= a[2];
    a[2]:= a[7]; a[7]:= a[6]; a[6]:= a[3];
    a[3]:= z;
end;

procedure process;
var
	dq,cq,t,i,s: longint;
begin
	dq:= 1; cq:= 0;
    inc(cq); q[cq]:= 1;
    t1[1]:= 1;

    while (dq <= cq) do
    begin
		t:= q[dq]; inc(dq);
        a:= f[t];

		for i:= 1 to 3 do
        begin
        	case i of
            	1: case1;
                2: case2;
                3: case3;
            end;
            s:= pos(a);

            if (t1[s] = 0) then
            begin
            	inc(cq);
                q[cq]:= s;
                t1[s]:= t;
                t2[s]:= i;

                if (s = stat) then exit;
            end;

            //
            a:= f[t];
        end;
    end;
end;

procedure output;
var
	i: longint;
    res: array[1..maxN] of longint;
begin
	cnt:= 0;
	while (t1[stat] <> stat) do
    begin
    	inc(cnt);
    	res[cnt]:= t2[stat];
    	stat:= t1[stat];
    end;	

    writeln(fo,cnt);
    for i:= cnt downto 1 do
    begin
    	write(fo,char(res[i]+64));
        if (i mod 60 = 0) or (i = 1) then writeln(fo);
    end;
    if (cnt = 0) then writeln(fo);
end;


begin
	assign(fi,'msquare.in'); reset(fi);
    assign(fo,'msquare.out'); rewrite(fo);
	//
    init;
    input;
    process;
    output;
    //
    close(fi);
    close(fo);
end.
