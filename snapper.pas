program snapper_chain;
uses crt;
var     fi,fo: text;
        n: byte;
        k: longint;
        num_test,t: integer;

begin
        assign(fi,'A-large.in'); reset(fi);
        assign(fo,'snapper.out'); rewrite(fo);
        //
        readln(fi,num_test);
        for t:= 1 to num_test do begin
                readln(fi,n,k);
                if ((k+1) mod (1 shl n) = 0) then writeln(fo,'Case #',t,': ON')
                else writeln(fo,'Case #',t,': OFF');
        end;
        //
        close(fi);
        close(fo);
end.
