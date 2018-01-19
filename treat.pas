uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 100010;
//type

var
	fi,fo: text;
    n,count,top: longint;
    f,next,st,dd,nb,low: array[1..maxN] of longint;
    vs: array[1..maxN] of boolean;


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
    for i:= 1 to n do
    	readln(fi,next[i]);
end;

procedure push(i: longint);
begin
	inc(top);
    st[top]:= i;
end;

function pop: longint;
begin
	pop:= st[top];
    dec(top);
end;

procedure visit1(i: longint);
var
	j,k,cnt: longint;
begin
	inc(count);
	nb[i]:= count;
    low[i]:= nb[i];

    push(i);

    j:= next[i];
    if not vs[j] then
    begin
    	if (nb[j] > 0) then
    		low[i]:= min(low[i],nb[j])
    	else
    	begin
    		visit1(j);
    		low[i]:= min(low[i],low[j]);
    	end;
    end;

    if (low[i] = nb[i]) then
   	begin
    	cnt:= 0;
        repeat
        	k:= pop;
            vs[k]:= true;

            //
            inc(cnt);
            dd[cnt]:= k;
        until k = i;
		
        for k:= 1 to cnt do
        	f[dd[k]]:= cnt;
    end;
end;

procedure visit2(i: longint);
var
	j: longint;
begin
	j:= next[i];
    if (j = i) then exit;

    if (f[j] = 1) then
    	visit2(j);

    f[i]:= f[i] + f[j];
end;

procedure process;
var
	i: longint;
begin
	count:= 0;
	for i:= 1 to n do
    	if (nb[i] = 0) then
        	visit1(i);

    for i:= 1 to n do
    	if (f[i] = 1) then
        	visit2(i);
end;

procedure output;
var	
	i: longint;
begin
	for i:= 1 to n do
    	writeln(fo,f[i]);
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
