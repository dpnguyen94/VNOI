uses math;
const
    inputfile = 'cvnm15.inp';
    outputfile = 'cvnm15.out';
    maxN = 15;
//type

var
	fi,fo: text;
    n,m,res: longint;
	k,id,list,d,w,day,work,inday: array[0..maxN] of longint;
    a: array[1..maxN,1..maxN] of longint;
	save: array[1..maxN] of longint;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;


procedure input;
var
	i,j,tmp: longint;
begin
	readln(fi,n,m);
    for i:= 1 to n do
    begin
    	read(fi,k[i]);
        for j:= 1 to k[i] do
        	read(fi,a[i,j]);

        id[i]:= i;
    end;

    for i:= 1 to n-1 do
    	for j:= i+1 to n do
        	if (k[i] > k[j]) then
            begin
            	tmp:= k[i]; k[i]:= k[j]; k[j]:= tmp;
                tmp:= id[i]; id[i]:= id[j]; id[j]:= tmp;

				save:= a[i]; a[i]:= a[j]; a[j]:= save;
            end;

    for i:= 1 to n do
    	list[id[i]]:= i;

    for i:= 1 to n do
    	for j:= 1 to k[i] do
        	a[i,j]:= list[a[i,j]];
end;


function isvalid(i: longint): boolean;
var
	cv,j: longint;
begin
	cv:= d[i];
	for j:= 1 to k[cv] do
    	if (w[a[cv,j]] = 0) or (w[a[cv,j]] > i) then exit(false);

    //	
    exit(true);
end;


procedure attempt(i: longint);
var
	j,t: longint;
    nextday: boolean;
begin
    for j:= 1 to n do
		if (w[j] = 0) and (i > k[j]) then
        begin
        	d[i]:= j;
            if isvalid(i) then
            begin
				//
				if (work[i-1] = m) then
                begin
                	work[i]:= 1;
                    day[i]:= day[i-1] + 1;
                    inday[j]:= day[i];
                end
                else
                begin
                	nextday:= false;

                	for t:= 1 to k[j] do
						if (inday[a[j,t]] = day[i-1]) then
		                begin
                        	work[i]:= 1;
                            day[i]:= day[i-1] + 1;
                            inday[j]:= day[i];

                            nextday:= true;
                            break;
                        end;

                    if not nextday then
                    begin
                    	work[i]:= work[i-1] + 1;
                    	day[i]:= day[i-1];
                    	inday[j]:= day[i];
                    end;
                end;

                //
                if (day[i] + (n - i) div m < res) then
					if (i < n) then
                    begin
                    	w[j]:= i;
                    	attempt(i+1);
                        w[j]:= 0;
                    end
                    else res:= day[n];
            end;
		end;
end;


procedure process;
begin
	day[0]:= 1;
	res:= maxlongint;
    attempt(1);
end;


procedure output;
begin
	writeln(fo,res);
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
