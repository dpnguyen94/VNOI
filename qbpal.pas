uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 150;
    LM = 1000000000;
type
	bignum = record
        len: longint;
    	d: array[0..50] of longint;
    end;

var
	fi,fo: text;
    n: longint;
 	s: string;
    f: array[0..maxN,0..maxN] of bignum;
	num1: bignum;

procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
begin
	readln(fi,s);
    n:= length(s);
end;

procedure plus(a,b: bignum; var c: bignum);
var
	i: longint;
begin
	with c do
    begin
    	fillchar(d,sizeof(d),0);

		len:= max(a.len,b.len);
    	for i:= 1 to len do
    	begin
    		d[i]:= d[i] + a.d[i] + b.d[i];
        	if (d[i] >= LM) then
        	begin
        		d[i+1]:= d[i] div LM;
            	d[i]:= d[i] mod LM;
       	 	end;
        end;
        //
		if (d[len+1] > 0) then inc(len);
	end;
end;

procedure minus(a,b: bignum; var c: bignum);
var
	i: longint;
begin
	with c do
    begin
    	fillchar(d,sizeof(d),0);

        len:= max(a.len,b.len);
        for i:=1 to len do
        begin
        	d[i]:= a.d[i] - b.d[i] + d[i];
            if d[i] < 0 then
            begin
            	d[i+1]:= -1;
                d[i]:= d[i] + LM;
            end;
        end;

        //
        if (d[len] = 0) then dec(len);
    end;
end;

procedure process;
var
	i,j: longint;	
begin
	with num1 do
    begin
        len:= 1;
    	d[1]:= 1;
    end;

	for j:= 1 to n do
    	for i:= j downto 1 do
        begin
        	plus(f[i+1,j],f[i,j-1],f[i,j]);
            minus(f[i,j],f[i+1,j-1],f[i,j]);

        	//f[i,j]:= f[i+1,j] + f[i,j-1] - f[i+1,j-1];

            if (s[i] = s[j]) then
            begin
            	//f[i,j]:= f[i,j] + f[i+1,j-1] + 1;

                plus(f[i,j],f[i+1,j-1],f[i,j]);
				plus(f[i,j],num1,f[i,j]);
            end;
        end;
end;

function count(x: longint): longint;
var
	cs: longint;
begin
	cs:= 0;
	while (x > 0) do
    begin
		inc(cs);
        x:= x div 10;
    end;

    exit(cs);
end;

procedure output;
var
	i,j: longint;
begin
	with f[1,n] do
	begin
    	write(fo,d[len]);
    	for i:= len-1 downto 1 do
        begin
			for j:= 1 to 9-count(d[i]) do
            	write(fo,0);
            write(fo,d[i]);
        end;
    end;
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
