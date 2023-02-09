program neural;
uses crt;

const NoOfInputs =  3;
      NoOfOutput = 12;
      NoOfHidden = 25;
      FileName:string = 'SOILWT.TXT';

type  Link1 = array[1..NoOfHidden, 1..NoOfInputs+1] of real;
      Link2 = array[1..NoOfOutput, 1..NoOfHidden+1] of real;

var   WLink1: Link1;
      WLink2: Link2;
      PClay, PSilt, PSand:real;
      AskYN:char;

procedure Init;
var x,y:integer;
begin
    for x:=1 to NoOfHidden do
      for y:=1 to NoOfInputs+1 do WLink1[x,y]:=0;
    for x:=1 to NoOfOutput do
      for y:=1 to NoOfHidden do WLink2[x,y]:=0;
end;

procedure GetWeights(FName:string);
var F:text;i,j,k:byte;
begin
  assign(F, FName);
  {$I-}
  reset(F);
  {$I+};
  if IOResult<>0 then
  begin
    writeln('No weight file exists!');
    halt;
  end;
  for j:=1 to NoOfHidden do
    for i:=1 to NoOfInputs+1 do
    begin
       read(F, WLink1[i,j]);
    end;
  readln(f);
  for k:=1 to NoOfOutput do
    for j:=1 to NoOfHidden+1 do
    begin
        read(F, WLink2[k, j]);
    end;
  close(F);
end;

function Logistic(x:real):real;
begin
  Logistic:=1/(1+exp(-x));
end;

procedure Ask(PClay, PSilt, PSand:real);
var z:array[1..NoOfOutput] of real;
    x:array[1..NoOfInputs] of real;
    y:array[1..NoOfHidden] of real;
    i,j,k:byte;
    u,v:real;
begin
    x[1]:=PClay;
    x[2]:=PSilt;
    x[3]:=PSand;
    for j:=1 to NoOfHidden do
    begin
      u:=WLink1[j, 1];
      for i:=1 to NoOfInputs do u:=u+WLink1[j,i+1]*x[i];
      y[j]:=Logistic(u);
    end;
    for k:=1 to NoOfOutput do
    begin
      v:=WLink2[k, 1];
      for j:=1 to NoOfHidden do v:=v+WLink2[k,j+1]*y[j];
      z[k]:=Logistic(v);
      if z[k]>0.85 then
        case k of
          1:writeln('Clay');
          2:writeln('Sandy Clay');
          3:writeln('Sandy Clay Loam');
          4:writeln('Sandy Loam');
          5:writeln('Loamy Sand');
          6:writeln('Sand');
          7:writeln('Clay Loam');
          8:writeln('Loam');
          9:writeln('Silty Clay');
         10:writeln('Silty Clay Loam');
         11:writeln('Silt Loam');
         12:writeln('Silt');
        end;
    end;
end;

begin
  clrscr;
  Init;
  GetWeights(FileName);
  AskYN:='Y';
  repeat
   writeln;
   write('%Sand=');
   readln(PSand);
   write('%Clay=');
   readln(PClay);
   PSilt:=1-PSand-PClay;
   writeln('%Silt=',PSilt:4:2);
   Ask(PClay, PSilt, PSand);
   write('Repeat?');
   AskYN:=readkey;
   AskYN:=upcase(AskYN);
  until AskYN<>'Y';
end.
