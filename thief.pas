program thief;
var     fi,fo: text;
        a: array[0..30] of longint;
        n,time: longint;

procedure input;
var     m,i,j: longint;
begin
        readln(fi,n);
        fillchar(a,sizeof(a),0);
        for i:= 1 to n do begin
                readln(fi,m);
                for j:= 0 to 30 do
                 inc(a[j],(m shr j) and 1);
        end;
end;

procedure process;
var     i,res: longint;
begin
        res:= 0;
        for i:= 0 to 30 do
         if (a[i] mod 2 = 1) then inc(res,1 shl i);

        writeln(fo,res);
end;

begin
        assign(fi,'thief.inp'); reset(fi);
        assign(fo,'thief.out'); rewrite(fo);
        //
        input;
        process;
        //
        close(fi);
        close(fo);
end.
