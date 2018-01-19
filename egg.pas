uses math;
const
    inputfile = '';
    outputfile = '';
    maxN = 1010;
    maxM = 10;
//type

var
    fi,fo: text;
    ntest,test,n,m: longint;
    f: array[0..maxN,0..maxM] of longint;


procedure openfile;
begin
    assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
begin
    readln(fi,n,m);
end;

procedure process;
var
    i,j,k,tmp: longint;
begin
    for i:= 1 to maxN do
        f[i,1]:= i;

    for i:= 1 to maxN do
        for j:= 2 to maxM do
        begin
            tmp:= maxlongint;
            for k:= 1 to i do
                tmp:= min(tmp,max(f[k-1,j-1],f[i-k,j]) + 1);

            f[i,j]:= tmp;
        end;
end;

procedure output;
begin
    writeln(fo,f[m,min(n,maxM)]);
end;

procedure closefile;
begin
    close(fi);
    close(fo);
end;


begin
    openfile;
    process;
    readln(fi,ntest);
    for test:= 1 to ntest do
    begin
        input;
        output;
    end;
    closefile;
end.
