program chatchit;
uses crt;
const   fi = '';
        fo = '';
var     s: ansistring;
        word: array[1..255] of ansistring;
        t: integer;
        f: text;

procedure enter;
begin
        assign(f,fi); reset(f);
        readln(f,s);
        s:= ' '+s;
        close(f);
end;

procedure init;
var     i,j: integer;
        st: ansistring;
begin
        t:= 1;
        for i:= 1 to length(s) do
         if (s[i] = ' ') then begin
                st:= '';
                j:= i+1;
                while (s[j] <> ' ') do begin
                        st:= st+s[j]; inc(j);
                        if (j > length(s)) then break;
                end;
                //
                word[t]:= st;
                inc(t);
         end;
        //
        dec(t);
end;

procedure edit;
var     i: integer;
begin
        assign(f,fo); rewrite(f);
        for i:= 1 to t do begin
                if (word[i] = 'k') then word[i]:= 'khong';
                if (word[i] = 'ko') then word[i]:= 'khong';
                if (word[i] = 'ng') then word[i]:= 'nguoi';
                if (word[i] = 'n') then word[i]:= 'nhieu';
                if (word[i] = 'dc') then word[i]:= 'duoc';
                if (word[i] = 'hok') then word[i]:= 'khong';
                if (word[i] = 'ntn') then word[i]:= 'nhu the nao';
                if (word[i] = 'kq') then word[i]:= 'ket qua';
                if (word[i][1] = 'j') then begin
                        delete(word[i],1,1);
                        word[i]:= 'gi'+ word[i];
                end;
                if (word[i][1] = 'w') then begin
                        delete(word[i],1,1);
                        word[i]:= 'qu'+ word[i];
                end;
                if (word[i][1] = 'f') then begin
                        delete(word[i],1,1);
                        word[i]:= 'ph'+ word[i];
                end;
                if (word[i][1] = 'd') and (word[i][2] = 'z') then begin
                        delete(word[i],1,2);
                        word[i]:= 'd'+ word[i];
                end;
                if (word[i][1] = 'z') then word[i][1]:= 'd';

                //
                if (i < t) then write(word[i],' ')
                else write(f,word[i]);
        end;
        close(f);
end;


begin
        enter;
        init;
        edit;
end.