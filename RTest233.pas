{$MODE OBJFPC}
program TestGenerator;
uses JudgerV2, SysUtils;
const
  Prefix = 'DOLLS._';
  maxN = 100000;

procedure GenTest(const FName: AnsiString; n: Integer;
  MaxV: Integer = 1000000000);
var
  f: TextFile;
  i, k: Integer;
begin
  TGenerator.CreateF(f, FName);
  try
    k := TGenerator.Rand(1, maxV);
    WriteLn(f, n, ' ', k);
    for i := 1 to n do
      begin
        Write(f, TGenerator.Rand(1, maxV));
        if i < n then Write(f, ' ');
      end;
  finally
    TGenerator.CloseF(f);
  end;
end;

procedure GenTest2(const FName: AnsiString; n: Integer;
  MaxV: Integer = 1000000000);
var
  f: TextFile;
  i, k: Integer;
begin
  TGenerator.CreateF(f, FName);
  try
    k := TGenerator.Rand(1, n);
    WriteLn(f, n, ' ', k);
    for i := 1 to n do
      begin
        Write(f, Abs(i - (n + 1) div 2) + 1);
        if i < n then write(f, ' ');
      end;
  finally
    TGenerator.CloseF(f);
  end;
end;

procedure GenAZ;
var
  c: Integer;
begin
  for c := 11 to 20 do
    GenTest(Prefix + IntToStr(c), Random(1000) + 1, Random(1000) + 1);
  for c := 21 to 30 do
    GenTest(Prefix + IntToStr(c), TGenerator.Rand(maxN div 2, maxN),
      TGenerator.Rand(maxN div 2, maxN));
end;

begin
  TTextEngine.ShowTitle('Generating test cases...');
  GenTest(Prefix + '01', 12, 9);
  GenTest(Prefix + '02', 20, 9);
  GenTest(Prefix + '03', 100, 100);
  GenTest(Prefix + '04', 1000, 1000);
  GenTest(Prefix + '05', 5000, 10000);
  GenTest(Prefix + '06', 66666);
  GenTest(Prefix + '07', 77777);
  GenTest(Prefix + '08', 88888);
  GenTest2(Prefix + '09', 99999);
  GenTest(Prefix + '10', 100000);
  GenAZ;
end.

