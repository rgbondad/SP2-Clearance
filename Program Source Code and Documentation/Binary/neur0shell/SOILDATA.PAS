program generate;

const Clay          =  1;
      SandyClay     =  2;
      SandyClayLoam =  3;
      SandyLoam     =  4;
      LoamySand     =  5;
      Sand          =  6;
      ClayLoam      =  7;
      Loam          =  8;
      SiltyClay     =  9;
      SiltyClayLoam = 10;
      SiltLoam      = 11;
      Silt          = 12;

var PClay, PSand, PSilt, k:real;
    i,j, Class:integer;

function Determine(PClay, PSand, PSilt:real):integer;
var class:integer;
begin
  if PClay >= 40 then
  begin
    class:=Clay;
    if PSand>=50 then Class:=SandyClay;
    if PSilt>=40 then Class:=SiltyClay
  end;
  if (PClay>=35) and (PClay<40) then
  begin
    Class:=ClayLoam;
    if PSand>=20 then Class:=SiltyClayLoam;
    if PSand>=45 then Class:=SandyClay;
  end;
  if (PClay>=27) and (PClay<35) then
  begin
    Class:=ClayLoam;
    if PSand>=20 then Class:=SiltyClayLoam;
    if PSand>=45 then Class:=SandyClayLoam;
  end;
  if (PClay>=20) and (PClay<27) then
  begin
    Class:=Loam;
    if PSilt<28 then Class:=SandyClayLoam;
    if PSilt>=50 then Class:=SiltLoam;
  end;
  if (PClay>=15) and (PClay<27) then
  begin
    Class:=Loam;
    if PSilt>=50 then Class:=SiltLoam;
    if PSand>=52 then Class:=SandyLoam;
  end;
  if (PClay>=12) and (PClay<15) then
  begin
    Class:=Loam;
    if PSilt>=50 then Class:=SiltLoam;
    if (PSand>=52) and (PSand<80) and (PSilt>=10) then Class:=SandyLoam;
    if (PSilt<10) and (Psand>=80) then Class:=LoamySand;
  end;
  if (PClay>=10) and (PClay<12) then
  begin
    Class:=Loam;
    if (PSilt>=50) and (PSilt<80) then Class:=SiltLoam;
    if PSilt>=80 then PSilt:=Silt;
    if (PSand>=52) and (PSand<80) then Class:=SandyLoam;
    if PSand<80 then Class:=LoamySand;
  end;
  if (PClay>=8) and (PClay<8) then
  begin
    Class:=Loam;
    if (PSilt>=50) and (PSilt<80) then Class:=SiltLoam;
    if PSilt>=80 then PSilt:=Silt;
    if (PSand>=52) and (PSand<77) then Class:=SandyLoam;
    if PSand<80 then Class:=LoamySand;
  end;
  if PClay<8 then
  begin
    Class:=SandyLoam;
    if (PSilt>=50) and (PSilt<80) then Class:=SiltLoam;
    if PSilt>=80 then Class:=Silt;
    if (PSilt<40) and (PSand>=70) then Class:=LoamySand;
    if (Psilt<40) and (PSand>=85) then Class:=Sand;
  end;
  Determine:=Class;
end;

function LayOut(p:integer):string;
var i:integer;Symbol, FinalStr:string;
begin
  FinalStr:='';
  {for i:=1 to 12 do
  begin
    Symbol:=' 0.1 ';
    if i=p then Symbol:=' 0.9 ';
    FinalStr:=FinalStr+Symbol;
  end;}
  str(1/24+1/12*(p-1):10:8, FinalStr);
  LayOut:=' '+FinalStr;
end;

begin
  writeln('Clay Sand Silt');
  for i:=1 to 100 do
   for j:=1 to 100-i do
   begin
     k:=100-(i*0.9)-(j*0.9);
     writeln(i*0.009:6:3,j*0.009:6:3,k*0.01:6:3,
             Layout(Determine(i*0.9,j*0.9, k)));
     {k:=100-i-j;
     writeln(i/100:6:3,j/100:6:3,k/100:6:3,
             Layout(Determine(i,j, k)));}
   end;
end.

