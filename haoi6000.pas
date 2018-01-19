uses math;
const
    inputfile = '';
    outputfile = '';
    LM = 1010;
    maxTT = 1000010;
type
    queue = record
        x,y,tt: longint;
    end;
var
    fi,fo: text;
    m,n: longint;
    a: array[0..LM,0..LM] of longint;
    d: array[0..LM,0..LM,1..4] of longint;

    qu: array[1..2 * maxTT] of queue;
    dq,cq: longint;


procedure openfile;
begin
    assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;


procedure input;
var
    i,j: longint;
begin
    fillchar(a,sizeof(a),$FF);

    readln(fi,m,n);
    for i:= 1 to m do
        for j:= 1 to n do
            read(fi,a[i,j]);
end;


procedure push(i,j,k,c: longint);
begin
    if (a[i,j] = -1) then exit;

    if (d[i,j,k] = 0) then
    begin
        inc(cq);
        qu[cq].x:= i;
        qu[cq].y:= j;
        qu[cq].tt:= k;

        d[i,j,k]:= c;
    end;
end;


procedure process;
var
    i,j,k,k1 : longint;
begin
    dq:= 1; cq:= 0;
    for i:= 1 to n do
    begin
        inc(cq);
        qu[cq].x:= 1;
        qu[cq].y:= i;
        if (a[1,i] = 0) then
        begin
            qu[cq].tt:= 1;
            d[1,i,1]:= 1;;
        end
        else
        begin
            qu[cq].tt:= 3;
            d[1,i,3]:= 1;
        end;
    end;

    //
    while (dq <= cq) do
    begin
        i:= qu[dq].x;
        j:= qu[dq].y;
        k:= qu[dq].tt;
        inc(dq);

        if (k = 1) then
        begin
            if (a[i-1,j] = 0) then k1:= 2
            else k1:= 4;
            push(i-1,j,k1,d[i,j,k] + 1);

            if (a[i,j+1] = 0) then k1:= 2
            else k1:= 3;
            push(i,j+1,k1,d[i,j,k] + 1);
        end;

        if (k = 2) then
        begin
            if (a[i,j-1] = 0) then k1:= 1
            else k1:= 4;
            push(i,j-1,k1,d[i,j,k] + 1);

            if (a[i+1,j] = 0) then k1:= 1
            else k1:= 3;
            push(i+1,j,k1,d[i,j,k] + 1);
        end;


        if (k = 3) then
        begin
            if (a[i-1,j] = 0) then k1:= 2
            else k1:= 4;
            push(i-1,j,k1,d[i,j,k] + 1);

                if (a[i,j-1] = 0) then k1:= 1
            else k1:= 4;
             push(i,j-1,k1,d[i,j,k] + 1);
        end;

        if (k = 4) then
        begin
            if (a[i,j+1] = 0) then k1:= 2
            else k1:= 3;
            push(i,j+1,k1,d[i,j,k] + 1);

            if (a[i+1,j] = 0) then k1:= 1
            else k1:= 3;
            push(i+1,j,k1,d[i,j,k] + 1);
        end;
    end;
end;


procedure output;
var
    i,res,cnt: longint;
begin
    res:= maxlongint;
    for i:= 1 to n do
    begin
        if (d[m,i,2] > 0) and (d[m,i,2] < res) then res:= d[m,i,2];
        if (d[m,i,4] > 0) and (d[m,i,4] < res) then res:= d[m,i,4];
    end;

    if (res = maxlongint) then
    begin
        writeln(fo,'0 0');
        exit;
    end;

    cnt:= 0;
    for i:= 1 to n do
    begin
        if (d[m,i,2] = res) then inc(cnt);
        if (d[m,i,4] = res) then inc(cnt);
    end;

    writeln(fo,res,' ',cnt);
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
