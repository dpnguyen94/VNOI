uses math;
const   MAX = 700000;
var     fi,fo: text;
        s,st: ansistring;
        p: array[0..MAX] of boolean;
        a: array[1..300000] of longint;
        n,k,len: longint;
        f: text;
        //time: longint;

procedure init_p;
var     i,j: longint;
begin
        fillchar(p,sizeof(p),true);

        s:= '';
        for i:= 2 to MAX do
         if (p[i]) then begin
                if (n = 0) then break;
                dec(n);
                str(i,st);
                s:= s+st;
                //
                j:= i+i;
                while (j <= MAX) do begin
                        p[j]:= false;
                        inc(j,i);
                end;
        end;
        //
        len:= length(s);
        //writeln(fo,len);
end;

{
function pos_max(x,y: longint): longint;
var     m,i: longint;
        c: char;
begin
        c:= s[x]; m:= x;
        for i:= x+1 to y do
         if (s[i] > c) then begin
                c:= s[i];
                m:= i;
         end;
        //
        pos_max:= m;
end;
}

procedure calc;
var     l,i,j,m: longint;
        c: char;
begin
        l:= 1; i:= 1;
        while (k > 0) do begin
                {
                a[i]:= pos_max(l,length(s)-(k-1));
                l:= pos_max(l,length(s)-(k-1))+1;
                inc(i);
                dec(k);
                }
                //
                c:= s[l]; m:= l;
                for j:= l+1 to len-(k-1) do begin
                 if (s[j] > c) then begin
                        c:= s[j];
                        m:= j;
                 end;
                 //
                 if (c = '9') then break;
                end;
                a[i]:= m;
                //
                l:= m+1;
                inc(i);
                dec(k);
        end;
        //
        for j:= 1 to i-1 do write(fo,s[a[j]]);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        readln(fi,n,k);
        init_p;
        k:= len-k;
        calc;
        //
        close(fi);
        close(fo);
end.
