uses math;
const
	inputfile = '';
    outputfile = '';
	maxN = 10;
type	
	arr = array[0..maxN,1..maxN] of longint;
var
	fi,fo: text;
    a,b: longint;
    d,power: array[0..maxN] of longint;
	fa,fb: arr;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;


procedure closefile;
begin
	close(fi);
    close(fo);
end;


procedure init;
var
	i: longint;
begin
    power[0]:= 1;
    for i:= 1 to 9 do
        power[i]:= power[i-1] * 10;
end;


procedure calc(num: longint; var f: arr);
var
	i,j,t,cnt,dg: longint;
begin
	fillchar(f,sizeof(f),0);
    fillchar(d,sizeof(d),0);

	t:= num;
    cnt:= 0;
    while (t > 0) do
    begin
		inc(cnt);
        d[cnt]:= t mod 10;
        t:= t div 10;
    end;

	for i:= 1 to cnt do
	begin
    	dg:= d[i];
		for j:= 1 to dg - 1 do
            inc(f[j,i],(num div power[i] + 1) * power[i-1]);

		if (dg = 0) then
    	begin
            inc(f[0,i],(num div power[i] - 1) * power[i-1]);
            inc(f[0,i],num mod power[i-1] + 1);
        end
        else
        begin
            inc(f[0,i],(num div power[i]) * power[i-1]);

            inc(f[dg,i],(num div power[i]) * power[i-1]);
            inc(f[dg,i],num mod power[i-1] + 1);
        end;

        for j:= dg + 1 to 9 do
            inc(f[j,i],(num div power[i]) * power[i-1]);
    end;	
end;


procedure process;
var
	i,j,sum1,sum2: longint;
begin
	calc(a-1,fa);
    calc(b,fb);
	
    for i:= 0 to 9 do
    begin
		sum1:= 0;
        for j:= 1 to 9 do inc(sum1,fa[i,j]);
        sum2:= 0;
        for j:= 1 to 9 do inc(sum2,fb[i,j]);

        write(fo,sum2 - sum1,' ');
    end;
    writeln(fo);
end;


procedure swap(var x,y: longint);
var
	z: longint;
begin
	z:= x; x:= y; y:= z;
end;


begin
	openfile;
    init;
    while TRUE do
    begin
    	readln(fi,a,b);
        if (a > b) then swap(a,b);
        if (a = 0) then break;

    	process;
    end;
    closefile;
end.
