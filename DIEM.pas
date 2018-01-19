uses math;
const
    inputfile = 'DIEM.INP';
    outputfile = 'DIEM.OUT';

//type
var
    fi,fo: text;
    n,res: int64;


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


procedure input;
begin
    readln(fi,n);
end;


procedure process;
var
    i,t: longint;
	j,m,tmp1,tmp2: int64;
begin
    res:= high(int64);

    t:= trunc(sqrt(n));
    for i:= 1 to t do
        begin
            j:= n div i;
            tmp1:= 4 + 3 * (j - 1);
            tmp2:= i * tmp1 - (i - 1) * j;

            m:= n mod i;
            if (m > 0) then tmp2:= tmp2 + 2 * m + 1;

            if (tmp2 < res) then res:= tmp2;
        end;
end;


procedure output;
begin
	writeln(fo,res);
end;


begin
    openfile;
    input;
    process;
    output;
    closefile;
end.
