uses math;
const
	inputfile = '';
  outputfile = '';
//type

var
	fi,fo: text;
  st: string;
  s: ansistring;
  dx: array[0..3] of longint = (0,1,0,-1);
  dy: array[0..3] of longint = (1,0,-1,0);


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
	s:= '';
  while TRUE do
  begin
  	readln(fi,st);
    if (st = '>>') then exit;
    s:= s + st;
  end;
end;

procedure process;
var
	t,i,u,v,dir: longint;
begin
	u:= 0;
  v:= 0;
	dir:= 0;

  for t:= 1 to 4 do
  begin
  	for i:= 1 to length(s) do
  	begin
  		if (s[i] = 'S') then
    	begin
  			u:= u + dx[dir];
    		v:= v + dy[dir];
    	end;

    	if (s[i] = 'R') then dir:= (dir + 1) mod 4;
    	if (s[i] = 'L') then dir:= (dir + 3) mod 4;
    end;
  end;

  if (u = 0) and (v = 0) then writeln(fo,'bounded')
  else writeln(fo,'unbounded');
end;

procedure output;
begin
end;


BEGIN
	openfile;
  while TRUE do
	begin
  	readln(fi,st);
    if (st = '[END]') then break;
    readln(fi);
    input;
    process;
    readln(fi);
  end;
  closefile;
END.
