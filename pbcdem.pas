uses math;
const	
	LM = 1000000000000000000;
type
 	bignum = record
		len: longint;
    	a: array[1..5] of int64;
	end;

var	
	f: array[0..4000] of bignum;
    n: longint;
	fi,fo: text;

procedure add(var x: bignum; y: bignum);
var	i,t: longint;
	carry: int64;
begin     	
	if x.len > y.len then
    begin
    	t:= y.len;
    	with x do
    	begin
        	carry:= 0;
			for i:= 1 to t do
    		begin
    			a[i]:= a[i] + y.a[i] + carry;
        		if (a[i] >= LM) then
        		begin
                	carry:= 1;
                	a[i]:= a[i] - LM;
        		end else carry:= 0;
    		end;

            while (carry > 0) do
            begin
            	inc(t);
                inc(a[t]);
                if (a[t] >= LM) then
                begin
                	carry:= 1;
                	a[t]:= a[t] - LM;
                end else carry:= 0;
            end;	

            len:= max(len,t);
    	end;
    end else
	with x do
    begin
    	len:= max(len,y.len);
        //
    	carry:= 0;
		for i:= 1 to len do
    	begin
    		a[i]:= a[i] + y.a[i] + carry;
        	if (a[i] >= LM) then
        	begin
                carry:= 1;
                a[i]:= a[i] - LM;
        	end else carry:= 0;
    	end;	

        //
        if (carry > 0) then
        begin
        	inc(len);
            a[len]:= 1;
        end;
    end;
end;


function count(x: int64): longint;
var 	res: longint;
begin
	res:= 0;
	while (x > 0) do
    begin
		inc(res);
        x:= x div 10;
    end;

    exit(res);
end;


procedure print;
var 	i,j,t: longint;
begin
	with f[n] do
    begin
    	write(fo,a[len]);
        dec(len);
		for i:= len downto 1 do
    	begin
    		t:= 9-count(a[i]);
        	for j:= 1 to t do write(fo,0);
        	write(fo,a[i]);
    	end;
    end;

    //
    writeln(fo);
end;


procedure process;
var	i,j,t,cnt,cnt1: longint;
begin
	f[0].len:= 1; f[0].a[1]:= 1;
    //
    {
    for i:= 1 to n-1 do
    begin
    	cnt1:= cnt;
        for j:= cnt downto 1 do
			if (list[j] + i <= n) then
            begin
            	t:= list[j] + i;
                add(f[t],f[list[j]]);

				//
                if not vs[t] then
                begin
                	vs[t]:= true;
                    inc(cnt1);
                    list[cnt1]:= t;
                end;	
            end;
        //
        cnt:= cnt1;
    end;
    }
    for i:=1 to n-1 do
    	for j:= n-i downto 0 do
        begin
        	if f[j].len = 0 then continue;
            add(f[j+i],f[j]);
        end;
end;


begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
    //
    readln(fi,n);
    process;
    print;
    //
    close(fi);
    close(fo);
end.
