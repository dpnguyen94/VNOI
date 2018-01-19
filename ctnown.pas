program ctnown;
uses crt;
var     fi,fo: text;
        num_test,t,tt: integer;
        f: array[0..350,0..350] of qword;
        p: array[1..350] of boolean;
        a: array[1..350] of integer;
        np,n: integer;

procedure init;
var     i,j: integer;
begin
        fillchar(p,sizeof(p),true);

        for i:= 2 to 350 do
         if p[i] then begin
                j:= i+i;
                while (j <= 350) do begin
                        p[j]:= false;
                        inc(j,i);
                end;
         end;
        //
        np:= 0;
        for i:= 2 to 350 do
         if p[i] then begin
                inc(np);
                a[np]:= i;
         end;
end;

procedure process;
var     i,j: integer;
        max,k: qword;
begin
        for i:= 1 to np do f[0,i]:= 1;
        for i:= 0 to 350 do f[i,0]:= 1;

        //
        for i:= 1 to 350 do
         for j:= 1 to np do begin
                if a[j] > i then begin f[i,j]:= f[i,j-1]; continue; end;

                max:= f[i-1,j];
                if (f[i,j-1] > max) then max:= f[i,j-1];

                k:= a[j];
                while (k <= i) do begin
                        if (f[i-k,j-1]*k > max) then max:= f[i-k,j-1]*k;
                        k:= k*a[j];
                end;

                f[i,j]:= max;
         end;
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        init;
        process;
        readln(fi,num_test);
        for t:= 1 to num_test do begin
                readln(fi,n);
                writeln(fo,f[n,np]);
        end;

        //
        close(fi);
        close(fo);
end.
