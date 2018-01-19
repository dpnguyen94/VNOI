uses math;
const
	inputfile = '';
  outputfile = '';
//type

var
	fi,fo: text;
  ntest,test: longint;
  n: longint;


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
	readln(fi,n);
end;

procedure process;
var
	i,x: longint;
  sum,smin,count,temp: longint;
  res: longint;
  rescount: int64;
begin
	res:= -maxlongint;
  rescount:= 0;

	sum:= 0;
  smin:= 0;
  count:= 1;
  for i:= 1 to n do
  begin
		read(fi,x);
    sum:= sum + x;
    temp:= sum - smin;

    //
    if (temp > res) then
    begin
    	res:= temp;
    	rescount:= count;
    end
    else
    	if (temp = res) then
    		rescount:= rescount + count;

    //
    if (sum < smin) then
    begin
    	smin:= sum;
      count:= 1;
    end
    else
    	if (sum = smin) then
      	inc(count);
  end;

  writeln(fo,res,' ',rescount);
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  readln(fi,ntest);
  for test:= 1 to ntest do
  begin
  	input;
    process;
  end;
  closefile;
END.
