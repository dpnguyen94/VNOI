uses math;
const
	inputfile = '';
  outputfile = '';
//type

var
	fi,fo: text;
  a,b: ansistring;
  ca,cb,res: array['a'..'z'] of longint;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
  assign(fo,outputfile); rewrite(fo);
end;

procedure closefile;
begin
	close(fi);
  close(fo);
end;

procedure input;
begin
	readln(fi,a);
  readln(fi,b);
end;

procedure process;
var
	i: longint;
  ch: char;
begin
	fillchar(ca,sizeof(ca),0);
  fillchar(cb,sizeof(cb),0);

  for i:= 1 to length(a) do
  	inc(ca[a[i]]);

  for i:= 1 to length(b) do
  	inc(cb[b[i]]);

  fillchar(res,sizeof(res),0);
  for ch:= 'a' to 'z' do
  begin
  	res[ch]:= min(ca[ch],cb[ch]);

    for i:= 1 to res[ch] do
    	write(fo,ch);
  end;

  writeln(fo);
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  while not eof(fi) do
  begin
  	input;
    process;
  end;
  closefile;
END.
