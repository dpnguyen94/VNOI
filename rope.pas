program rope;
uses crt;
var     fi,fo: text;
        num_test,t: integer;
        a,b: array[1..1000] of integer;
        n: integer;

procedure input;
var     i: integer;
begin
        readln(fi,n);
        for i:= 1 to n do readln(fi,a[i],b[i]);
end;

function is_its(i,j: integer): boolean;
begin
        if (a[i] - a[j])*(b[i] - b[j]) < 0 then exit(true)
        else exit(false);
end;

procedure process;
var     i,j: integer;
        cnt: longint;
begin
        cnt:= 0;
        for i:= 1 to n-1 do
         for j:= i+1 to n do
          if is_its(i,j) then inc(cnt);
        //
        writeln(fo,'Case #',t,': ',cnt);
end;

begin
        assign(fi,'a-large.in'); reset(fi);
        assign(fo,'rope.out'); rewrite(fo);
        //
        readln(fi,num_test);
        for t:= 1 to num_test do begin
                input;
                process;
        end;
        //
        close(fi);
        close(fo);
end.
