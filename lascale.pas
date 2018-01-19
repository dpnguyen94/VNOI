uses math;
const
	LM = 17;
type
	mang = array[0..LM] of longint;
var
	fi,fo: text;
	cale,a: mang;
    m: longint;

procedure input;
begin
	readln(fi,m);
end;

procedure init;
var
	i: longint;
begin
	cale[0]:= 1;
	for i:= 1 to LM do cale[i]:= cale[i-1] * 3;
end;

procedure output;
var
	i,cales: longint;
begin
	cales:= 0;
    for i:= 0 to LM do
    	if (a[i] = 1) then inc(cales);

    write(fo,cales,' ');
    for i:= 0 to LM do
    	if (a[i] = 1) then write(fo,cale[i],' ');
end;

procedure solve;
var
	w,i,t,cnt: longint;
	res: mang;
begin
	w:= 0;
    for i:= 0 to 17 do
    	if (a[i] = 1) then inc(w,cale[i]);

    if (w = m) then
    begin
    	writeln(fo,0,' ');
        output;

        //
        close(fi); close(fo);
        halt;
    end;

    if (w > m) then
    begin
    	t:= w - m;

        cnt:= 0;
        i:= LM;
        while (i >= 0) do
        begin
			if (t >= cale[i]) and (a[i] = 0) then begin
            	dec(t,cale[i]);
                inc(cnt);
                res[cnt]:= cale[i];
            end;	

    		dec(i);

            if (t = 0) then break;
        end;

        if (t = 0) then
        begin
        	write(fo,cnt,' ');
        	for i:= cnt downto 1 do write(fo,res[i],' ');
            writeln(fo);
            output;

            //
            close(fi); close(fo);
            halt;
        end;
    end;
end;

procedure attempt(i: longint);
var
	j: longint;
begin
	if (i > LM) then
    begin
    	solve;
        exit;
    end;

    for j:= 0 to 1 do
    begin
		a[i]:= j;
        attempt(i+1);
    end;
end;

procedure process;
begin
	attempt(0);
end;


begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
	//
    input;
    init;
    process;
    //
    close(fi);
    close(fo);
end.
