program nkedit;
uses crt;
const   fi = '';
        fo = '';
var     s,p: string[50];
        k: longint;
        c: array[0..50,0..50] of byte;
        f: text;

procedure nhap;
begin
        assign(f,fi); reset(f);
        readln(f,k);
        readln(f,s);
        readln(f,p);
        close(f);
end;

procedure xuli;
var     i,j,s_i,p_j,max,num: byte;
begin
        assign(f,fo); rewrite(f);

        fillchar(c,sizeof(c),0);
        //
        num:= 0;
        repeat
                max:= 0;
                for i:= 1 to length(s) do
                 for j:= 1 to length(p) do
                  if s[i] = p[j] then begin
                        c[i,j]:= c[i-1,j-1] + 1;
                        if c[i,j] > max then begin
                                max:= c[i,j];
                                s_i:= i;
                                p_j:= j;
                        end;
                  end
                  else c[i,j]:= 0;
                //
                if (max < k) or (max = 0) then break;
                //
                delete(s,s_i-max+1,max);
                delete(p,p_j-max+1,max);
                inc(num);
        until FALSE;
        //
        writeln(f,num);
        writeln(f,s);
        writeln(f,p);

        close(f);
end;


begin
        nhap;
        xuli;
end.