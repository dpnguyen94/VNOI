uses math;
const
    maxL = 300;
var
    fi,fo: text;
    s: ansistring;
    pos,num: array[1..maxL] of longint;
    n,x,y: longint;
    dx: array[0..7] of longint = (0,1,1,1,0,-1,-1,-1);
    dy: array[0..7] of longint = (1,1,0,-1,-1,-1,0,1);

procedure input;
begin
    readln(fi,x,y);
    readln(fi,s);
end;

function isletter(i: longint): boolean;
begin
    if ( (s[i] >= 'A') and (s[i] <= 'Z') )
        or ( (s[i] >= 'a') and (s[i] <= 'z') ) then exit(true);
    exit(false);
end;

function isnumber(i: longint): boolean;
begin
    if (s[i] >= '0') and (s[i] <= '9') then exit(true);
    exit(false);
end;

procedure init;
var
    i,j,m,code: longint;
    snum: ansistring;
    c: char;
begin
    n:= length(s);

    for i:= 1 to n do
    begin
        if isletter(i) or (s[i] = ')') then
        begin
            snum:= '';
            j:= i+1;
            while (j <= n) and (isnumber(j)) do
            begin
                snum:= snum + s[j];
                inc(j);
            end;
            if (snum = '') then num[i]:= 1
            else val(snum,num[i],code);
        end;
    end;

    {
    m:= 0;
    for i:= 1 to n do
    begin
        if (s[i] = '(') then
        begin
            inc(m);
            a[i]:= m;
            c:= s[i];
        end;

        if (s[i] = ')') then
        begin
            if (c = '(') then posc[m]:= i
            else
                for j:= m downto 1 do
                    if (posc[j] = 0) then
                    begin
                        posc[j]:= i;
                        break;
                    end;
            c:= s[i];
        end;
    end;

    for i:= 1 to m do write(fo,posc[i],' ');
    writeln(fo);
    for i:= 1 to n do
        if (s[i] = '(') then write(fo,a[i],' ');
    }

    m:= 0;
    for i:= 1 to n do
    begin
        if (s[i] = ')') then
        begin
            for j:= i-1 downto 1 do
                if (s[j] = '(') and (pos[j] = 0) then
                begin
                    pos[j]:= i;
                    break;
                end;

        end;
    end;

    {
    for i:= 1 to n do
        if (s[i] = '(') then write(fo,pos[i],' ');
    writeln(fo);
    for i:= 1 to n do
        if (s[i] = ')') or (isletter(i)) then write(fo,num[i],' ');
    }
end;

function opens(i,j: longint): ansistring;
var
    st1,st2: ansistring;
    k,t: longint;
begin
    if (i > j) then exit('');

    st1:= '';
    k:= i;
    while (k <= j) do
    begin
        if isletter(k) then
        begin
            for t:= 1 to num[k] do
                st1:= st1 + s[k];
        end;

        if (s[k] = '(') then
        begin
            st2:= opens(k+1,pos[k]-1);
            for t:= 1 to num[pos[k]] do st1:= st1 + st2;
            k:= pos[k]+1;
            continue;
        end;

        inc(k);
    end;

    exit(st1);
end;

procedure process1;
var
    sres: ansistring;
    i: longint;
begin
    sres:= opens(1,n);
    for i:= 1 to length(sres) do
    begin
        write(fo,sres[i]);
        if (i mod 70 = 0) then writeln(fo);
    end;
    writeln(fo);
    s:= sres;
end;

procedure process2;
var
    i,direct: longint;
begin
    n:= length(s);
    direct:= 0;
    for i:= 1 to n do
    begin
        if (s[i] = 'D') then
        begin
            x:= x + dx[direct];
            y:= y + dy[direct];
        end;

        if (s[i] = 'd') then
        begin
            x:= x - dx[direct];
            y:= y - dy[direct];
        end;

        if (s[i] = 'Q') then direct:= (direct + 1) mod 8;
        if (s[i] = 'q') then
        begin
            direct:= direct - 1;
            if (direct < 0) then direct:= direct + 8
            else direct:= direct mod 8;
        end;

    end;

    writeln(fo,x,' ',y);
end;

begin
    assign(fi,'XLX3.in'); reset(fi);
    assign(fo,'XLX3.out'); rewrite(fo);
    //
    input;
    init;
    process1;
    process2;
    //
    close(fi);
    close(fo);
end.
