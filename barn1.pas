{
ID: ndchiph1
PROG: barn1
LANG: PASCAL
}
program barn1;
uses crt;
var     fi,fo: text;
        m,s,c: longint;
        h,f,list: array[1..200] of longint;

procedure input;
var     i,j,k: longint;
begin
        readln(fi,m,s,c);
        for i:= 1 to c do begin
                readln(fi,j);
                list[i]:= j;
        end;
        //
        for i:= 1 to c-1 do
         for j:= i+1 to c do
          if list[i] > list[j] then begin
                k:= list[i];
                list[i]:= list[j];
                list[j]:= k;
          end;
end;

procedure greedy;
var     i,j,k,cnt,max,res,t1,t2,t: longint;
begin
        cnt:= 1;
        h[1]:= 1; f[1]:= c;
        for i:= 2 to m do begin
                max:= 0;
                for j:= 1 to cnt do begin
                        for k:= h[j] + 1 to f[j] do begin
                         if (list[k] - list[k-1] - 1 > max) then begin
                                max:= list[k] - list[k-1] - 1;
                                t1:= k - 1; t2:= k;
                                t:= j;
                         end;
                        end;
                end;
                if (max = 0) then break;
                inc(cnt);
                h[cnt]:= t2; f[cnt]:= f[t];
                f[t]:= t1;
        end;
        //
        res:= 0;
        for j:= 1 to cnt do inc(res,list[f[j]]-list[h[j]]+1);
        //
        writeln(fo,res);
end;


begin
        assign(fi,'barn1.in'); reset(fi);
        assign(fo,'barn1.out'); rewrite(fo);
        //
        input;
        greedy;
        //
        close(fi);
        close(fo);
end.
