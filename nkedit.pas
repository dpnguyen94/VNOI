program nkedit;
uses crt;
const   fi = '';
        fo = '';
var     s,p: ansistring;
        k: longint;
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
var     i,j,l,si,pj,max,num: byte;
        swap: boolean;
        c: ansistring;
begin
        //init;
        swap:= false;
        if length(s) > length(p) then begin
                c:= s; s:= p; p:= c;
                swap:= true;
        end;
        //
        num:= 0;
        repeat
                max:= 0;
                //
                for i:= 1 to length(s) do
                 for l:= 1 to length(s)-i+1 do
                  for j:= 1 to length(p) do begin
                        if (copy(s,i,l) = copy(p,j,l)) and (l > max) then begin
                                max:= l; si:= i; pj:= j;
                        end;
                  end;
                //
                if (max = 0) or (max < k) then break;
                //
                delete(s,si,max);
                delete(p,pj,max);
                inc(num);
        until FALSE;

        //
        assign(f,fo); rewrite(f);
        writeln(f,num);
        //
        if (swap) then begin
                writeln(f,p,);
                writeln(f,s,);
        end
        else begin
                writeln(f,s,);
                writeln(f,p,);
        end;
        close(f);
end;

begin
        nhap;
        xuli;
end.
