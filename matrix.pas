uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 200 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  m,n: longint;
  f: array[0..LM,0..LM] of longint;


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
var
	i,j,num: longint;
begin
	readln(fi,m,n);
  for i:= 1 to m do
  	for j:= 1 to n do
    begin
    	read(fi,num);
      if (num = 1) then
      	f[i,j]:= f[i - 1,j] + f[i,j - 1] - f[i - 1,j - 1] + 1
      else f[i,j]:= f[i - 1,j] + f[i,j - 1] - f[i - 1,j - 1] - 1;
    end;
end;

function getsum(x1,y1,x2,y2: longint): longint;
begin
	if (y1 > y2) then exit(0);
	getsum:= f[x2,y2] - f[x1 - 1,y2] - f[x2,y1 - 1] + f[x1 - 1,y1 - 1];
end;

procedure process;
var
  i,j,k,res,countres,smin,countmin,sum,temp: longint;
begin
	res:= -maxlongint;
  countres:= 0;

  for i:= 1 to n do
  	for j:= i to n do
    begin
    	sum:= getsum(1,i,1,j);
      if (sum > res) then
      begin
      	res:= sum;
        countres:= 1;
      end
      else
      	if (sum = res) then
        	inc(countres);

      smin:= -getsum(1,i + 1,1,j - 1);
      countmin:= 1;

      //
      for k:= 2 to m do
      begin
      	sum:= getsum(k,i,k,j);
        if (sum > res) then
        begin
        	res:= sum;
          countres:= 1;
        end
        else
        	if (sum = res) then
          	inc(countres);

        //
      	sum:= getsum(1,i,k,j) - getsum(1,i + 1,k - 1,j - 1);
        temp:= sum - smin;
        if (temp > res) then
        begin
        	res:= temp;
          countres:= countmin;
        end
        else
        	if (temp = res) then
          	countres:= countres + countmin;

        //
        temp:= sum - getsum(k,i,k,j) - getsum(k,i + 1,k,j - 1);
        if (temp < smin) then
        begin
        	smin:= temp;
          countmin:= 1;
        end
        else
        	if (temp = smin) then
          	inc(countmin);
      end;
    end;

  writeln(fo,res,' ',countres);
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
