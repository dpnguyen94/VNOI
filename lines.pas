program lines;
uses crt;
const   fi = 'lines.inp';
        fo = 'lines.out';
var     n: integer;
        s,a,p,q,prev: array[1..10000] of integer;
        f: text;

procedure input;
var     i: integer;
begin
        assign(f,fi); reset(f);

        readln(f,n);
        for i:= 1 to n do read(f,p[i]);
        for i:= 1 to n do read(f,q[i]);

        close(f);
end;



procedure process;
var     i,j: integer;
begin
        //init;
        for i:= 1 to n do
        for j:= 1 to n do
                if q[j] = p[i] then begin
                        a[i]:= j;
                        break;
                end;

        //process
        for i:= 1 to n do begin
                s[i]:= 1;
                prev[i]:= 0;
        end;

        for i:= 2 to n do
        for j:= 1 to i-1 do begin
                if (a[i] > a[j]) and (s[j] + 1 > s[i]) then begin
                        s[i]:= s[j]+1;
                        prev[i]:= j;
                end;
        end;
end;

procedure print_res;
var     i,j,max: integer;
begin
        assign(f,fo); rewrite(f);

        max:= s[1];
        for i:= 2 to n do
                if s[i] > max then begin
                        max:= s[i];
                        j:= i;
                end;
        writeln(f,max);

        repeat
                write(f,j,' '); //so hieu cua cac doan duoc noi;
                j:= prev[j];
        until j = 0;

        close(f);
end;


begin
        input;
        process;
        print_res;
end.