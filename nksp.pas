uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 1010;
//type

var
	fi,fo: text;
    s: ansistring;
    n: longint;
    p,sp: array[0..maxN,0..maxN] of boolean;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i,le,ri: longint;	
begin
	readln(fi,s);
    n:= length(s);

    //
    for i:= 1 to n do
    begin
		le:= i-1; ri:= i+1;
        while (le >= 1) and (ri <= n) and (s[le] = s[ri]) do
        begin
        	p[le,ri]:= true;
        	dec(le);
            inc(ri);
        end;

        le:= i; ri:= i+1;
		while (le >= 1) and (ri <= n) and (s[le] = s[ri]) do
        begin
        	p[le,ri]:= true;
        	dec(le);
            inc(ri);
        end;
    end;
end;

procedure process;
var
	i,j,k,res: longint;
begin
	res:= 0;
	for i:= 2 to n do
    	for j:= i-1 downto 1 do
        begin
			if (p[j,i]) then
            begin
            	sp[j,i]:= true;
                inc(res);
                continue;
            end;

            for k:= j+1 to i-1 do
            	if sp[j,k] and sp[k+1,i] then
                begin
					sp[j,i]:= true;
                    inc(res);
                    break;
                end;
        end;

    //
    writeln(fo,res);
end;

procedure output;
//var
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
