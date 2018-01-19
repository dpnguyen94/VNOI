program sophongphu;
uses crt;
const   MAX = 100000;
var     sum: array[1..MAX] of longint;
        l,r: longint;

procedure process;
var     i,j: longint;
begin
        //init;
        for i:= 1 to MAX do sum[i]:= 1;

        //process;
        for i:= 2 to (r div 2) do begin
                j:= i + i;
                while (j <= r) do begin
                        inc(sum[j],i);
                        inc(j,i);
                end;
        end;

end;

procedure count;
var     i,cnt: longint;
begin
        cnt:= 0;
        for i:= l to r do
                if sum[i] > i then inc(cnt);
        writeln(cnt);
end;

begin
		//input;
        readln(l,r);

        process;
        count;
        readln;
end.

