uses math;
const
	LM = 1100000;
    maxN = 21;	
//type

var                                	
	fi,fo: text;
    n,k,sn,tn: longint;
    a,q,d: array[0..LM] of longint;
    num,f: array[0..maxN] of longint;


procedure init;
var
	i: longint;
begin
	f[0]:= 1;
    for i:= 1 to 21 do
    	f[i]:= f[i-1] * 2;
end;

procedure input;
var       	
	i,j: longint;
begin
	readln(fi,n,k);
    for i:= 1 to n do
    begin
        read(fi,num[i]);
        inc(num[i],num[i-1]);
        for j:= num[i-1] + 1 to num[i] do read(fi,a[j]);
    end;

    for i:= 1 to n do
    begin
    	read(fi,j);
        inc(sn, j * f[n-i]);
    end;

    tn:= f[n - k];
end;

procedure process;
var
	dq,cq,s,t,tt,i,j: longint;
begin
	dq:= 1; cq:= 1;
    q[1]:= sn;
    d[sn]:= 1;

    while (dq <= cq) do
    begin
		s:= q[dq];
        inc(dq);

        for i:= 1 to n do
        begin
        	t:= s or f[n-i]; //onbit

        	for j:= num[i-1] + 1 to num[i] do
				t:= t and not f[n-a[j]]; //offbit

            //
            if (d[t] <> 0) then continue;
            //
        	inc(cq);
        	q[cq]:= t;
        	d[t]:= d[s] + 1;

        	if (d[tn] <> 0) then exit;
        end;		
    end;	
end;

procedure output;
begin
	writeln(fo,d[tn] - 1);
end;

begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
	//
    init;
    input;
    process;
    output;
    //
    close(fi);
    close(fo);
end.
