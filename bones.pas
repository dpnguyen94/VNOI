program bones;
uses crt;
var     s: array[1..80] of integer;
        s1,s2,s3: integer;

procedure nhap;
begin
        readln(s1,s2,s3);
end;

procedure xuli;
var     i,j,k,max: integer;
begin
        fillchar(s,sizeof(s),0);
        for i:= 1 to s1 do
         for j:= 1 to s2 do
          for k:= 1 to s3 do inc(s[i+j+k]);
        //
        max:= 0;
        for i:= 1 to 80 do
                if (s[i] > max) then begin
                        max:= s[i];
                        j:= i;
                end;
        writeln(j);
end;

begin
        nhap;
        xuli;
end.
