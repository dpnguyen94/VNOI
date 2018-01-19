{
ID: ndchiph1
PROG: contact	
LANG: PASCAL
}
uses math;
const
	maxL = 12;
	maxV = 10000;
    LM1 = 200010;
    LM2 = maxV * maxL;
var
	fi,fo: text;
    a,b,n,lenc,cnt: longint;
    c: array[0..LM1] of longint;
    f: array[0..maxV,1..maxL] of longint;
    num,value,leng: array[0..LM2] of longint;


procedure input;
var
	i: longint;
	s,st: ansistring;
begin
	readln(fi,a,b,n);
	s:= '';
    while not eof(fi) do
    begin
    	readln(fi,st);
        s:= s + st;
    end;
    lenc:= length(s);

    for i:= 1 to lenc do c[i]:= ord(s[i]) - ord('0');
end;

procedure process;
var	
	i,j,k,t: longint;	
begin
	for i:= 1 to lenc do
    begin          	
    	t:= 0;
        for j:= 0 to maxL-1 do
        begin
        	k:= i+j;
        	if (k > lenc) then break;

			t:= (t * 2) + c[k];
            inc(f[t,j+1]);
		end;
    end;
end;

procedure init;
var  	
	i,j: longint;
begin
	cnt:= 0;
	for i:= 0 to maxV do
    	for j:= 1 to maxL do
        begin
        	if (j >= a) and (j <= b) and (f[i,j] > 0) then
            begin
				inc(cnt);
                num[cnt]:= f[i,j];
                value[cnt]:= i;
                leng[cnt]:= j;
            end;
        end;
end;

procedure swap(var x,y: longint);
var
	z: longint;
begin
	z:= x; x:= y; y:= z;
end;

procedure sort(le,ri: longint);
var
	i,j,t,t1,t2,k: longint;
begin
	if (le >= ri) then exit;
	i:= le; j:= ri;
    k:= (i + j) div 2;
    t:= num[k];
    t1:= leng[k];
    t2:= value[k];

    repeat
        while (num[i] < t) or ( (num[i] = t) and (leng[i] > t1) )
            or ( (num[i] = t) and (leng[i] = t1) and (value[i] > t2) )
            	do inc(i);

        while (num[j] > t) or ( (num[j] = t) and (leng[j] < t1) )
            or ( (num[j] = t) and (leng[j] = t1) and (value[j] < t2) )
            	do dec(j);

        if (i <= j) then
        begin
        	if (i < j) then
            begin
				swap(num[i],num[j]);
                swap(leng[i],leng[j]);
                swap(value[i],value[j]);
            end;
        	inc(i); dec(j);
        end;
    until i > j;
	
    sort(le,j);
    sort(i,ri);
end;

function sres(i,j: longint): string;
var
	t: longint;
    res: string;
begin
	res:= '';
	while (i > 0) do
    begin
    	res:= char( (i mod 2) + 48 ) + res;
        i:= i div 2;
    end;

	for t:= 1 to j-length(res) do res:= '0' + res;

    exit(res);
end;

procedure output;
var
	i,j: longint;
    first: boolean;
begin	                          	
	j:= 0;
    while (cnt > 0) do
    begin
    	if (num[cnt] = num[cnt+1]) then
        begin
        	inc(j);
			if (j > 1) then write(fo,' ');
            write(fo,sres(value[cnt],leng[cnt]));
            if (j = 6) or (num[cnt-1] < num[cnt]) then
            begin
            	writeln(fo);
                j:= 0;
            end;
        end else
        begin
        	dec(n);
            if (n < 0) then break;

        	writeln(fo,num[cnt]);
            //
            inc(j);
            write(fo,sres(value[cnt],leng[cnt]));
            if (num[cnt-1] < num[cnt]) then
            begin
            	writeln(fo);
                j:= 0;
            end;
        end;
    	
        dec(cnt);
    end;	
end;

begin
	assign(fi,'contact.in'); reset(fi);
    assign(fo,'contact.out'); rewrite(fo);
	//
    input;
    process;
    init;
    sort(1,cnt);
    output;
    //
    close(fi);
    close(fo);
end.
