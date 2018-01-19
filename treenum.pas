program treenum;
uses crt;
const   MAX = 10000000000000000000;
var     fi,fo: text;
        n,sum: qword;

procedure process;
var     i,j: qword;
begin
        sum:= 3;
        j:= 1;
        while (sum < n) do begin
                inc(j);
                i:= sum+1;
                sum:= sum+i;
        end;
        writeln(fo,j);
end;


begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        //readln(fi,ntest);
        //for t:= 1 to ntest do begin
                readln(fi,n);
                process;
        //end;
        //
        close(fi);
        close(fo);
end.
