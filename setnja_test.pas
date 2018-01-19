//const
	
var	
	i,j,t: longint;
    fo: text;
begin
	assign(fo,'setnja.in1'); rewrite(fo);
  for i:= 1 to 10000 do write(fo,'*');
  close(fo);
end.
