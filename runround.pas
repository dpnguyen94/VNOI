{
ID: ndchiph1
PROG: runround
LANG: PASCAL
}
uses math;
//const

type
	mang = array[0..10] of longint;
	
var
	fi,fo: text;
    a,b,d: mang;
    ndigit,cnt: longint;
    free,frnum: array[0..10] of boolean;
    exist: boolean;

procedure input;
var	i: longint;
    s: string;
begin
	readln(fi,s);
	for ndigit:= 1 to length(s) do a[ndigit-1]:= ord(s[ndigit]) - ord('0');
end;


procedure init;
begin
	fillchar(free,sizeof(free),true);
    fillchar(frnum,sizeof(frnum),true);
end;


procedure printres;
var 	i: longint;
begin
	for i:= 0 to cnt-1 do write(fo,d[i]);
    writeln(fo);
end;


function bigger(x,y: mang): boolean;
var	i: longint;
begin
	for i:= 0 to cnt-1 do
    begin
    	if x[i] > y[i] then exit(true);
        if x[i] < y[i] then exit(false);
    end;

    exit(false);
end;


procedure valid;
var	i: longint;
begin
	if (cnt = ndigit) then
    begin
		if bigger(b,a) and (not bigger(b,d)) then
        begin
        	d:= b;
            exist:= true;
        end;
    end else
    begin
    	if not bigger(b,d) then
        begin
        	d:= b;
            exist:= true;
        end;
    end;
end;


procedure attempt1(i,passed: longint);
var 	j,t,k: longint;
begin
    if (i = 0) then t:= a[0]
    else t:= 1;

    for j:= t to 9 do
    	if (frnum[j]) then
        begin
			k:= (i + j) mod cnt;
            if (k = 0) then
            begin
            	if (passed = cnt-1) then
                begin
                	b[i]:= j;
                    valid;
                end;
            end;

			if (free[k]) then
            begin
            	b[i]:= j;
                //
                frnum[j]:= false;
                free[k]:= false;
                //
                attempt1(k,passed+1);
                //
                free[k]:= true;
                frnum[j]:= true;
            end;
        end;
end;


procedure attempt2(i,passed: longint);
var 	j,k: longint;
begin
    for j:= 1 to 9 do
    	if (frnum[j]) then
        begin
			k:= (i + j) mod cnt;
            if (k = 0) then
            begin
            	if (passed = cnt-1) then
                begin
                	b[i]:= j;
                    valid;
                end;
            end;

			if (free[k]) then
            begin
            	b[i]:= j;
                //
                frnum[j]:= false;
                free[k]:= false;
                //
                attempt2(k,passed+1);
                //
                free[k]:= true;
                frnum[j]:= true;
            end;
        end;
end;


procedure process2;
begin
	//
    while TRUE do
    begin
    	init;
    	inc(cnt);
        exist:= false;
        free[0]:= false;
        attempt2(0,0);
        if exist then
        begin
        	printres;
            exit;
        end;
    end;
end;


procedure process1;
var	i: longint;
begin
	//init;
    for i:= 0 to 10 do d[i]:= maxlongint;

    init;

    //
    cnt:= ndigit;
    exist:= false;
    free[0]:= false;
    attempt1(0,0);
	if not exist then process2
    else printres;
end;


begin
	assign(fi,'runround.in'); reset(fi);
    assign(fo,'runround.out'); rewrite(fo);
	//
    input;
    process1;
    //
    close(fi);
    close(fo);
end.
