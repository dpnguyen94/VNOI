program nkletter;
uses crt;
var     sb,se,b,e: string;
        fi,fo: text;

procedure nhap;
begin
        readln(fi,sb);
        readln(fi,se);
end;

procedure xuli;
var     n,i: longint;
begin
        n:= length(sb);
        if n>length(se) then n:= length(se);
        //
        for i:= n downto 0 do begin
                b:= copy(sb,length(sb)-i+1,i);
                e:= copy(se,1,i);
                if b=e then break;
        end;

        writeln(fo,length(sb)+length(se)-i);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        nhap;
        xuli;
        //
        close(fi);
        close(fo);
end.

