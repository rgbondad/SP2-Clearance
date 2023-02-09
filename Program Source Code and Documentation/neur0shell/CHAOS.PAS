program Chaos;
uses crt;

const MaxCell=10;
var   Board:array[1..MaxCell, 1..MaxCell] of integer;
      SumLeft, SumRight, Number:real;

procedure ChanceDirection(var dx,dy:integer);
begin
 dx:=-1+trunc(random(300)/100);
 dy:=-1+trunc(random(300)/100);
end;

procedure ChancePlace(var x,y:byte);
begin
 x:=random(MaxCell)+1;
 y:=random(MaxCell)+1;
end;

procedure Init;
var x,y:byte;
begin
 SumLeft:=0; SumRight:=0; Number:=0;
 randomize;
 for x:=1 to MaxCell do
  for y:=1 to MaxCell do
   Board[x,y]:=random(2);
end;

procedure Drawing;
var x,y:byte;
begin
 randomize;
 for x:=1 to MaxCell do
  for y:=1 to MaxCell do
  begin
   gotoxy(x*4, y*2);
   write(Board[x,y]:3);
  end;
end;

function StrengthOfEnergy:integer;
var NumberLeft, NumberRight:integer;
    x, y:byte;
begin
 NumberLeft:=0;
 for x:=1 to MaxCell div 2 do
  for y:=1 to MaxCell do
   NumberLeft:=NumberLeft+Board[x,y];
 NumberRight:=0;
 for x:=MaxCell div 2 + 1 to MaxCell do
  for y:=1 to MaxCell do
   NumberRight:=NumberRight+Board[x,y];
 StrengthOfEnergy:=round(0.25*(NumberRight-NumberLeft)+10);
 Number:=Number+1;
 SumLeft:=SumLeft+NumberLeft;
 SumRight:=SumRight+NumberRight;
 gotoxy(65,1);write(NumberLeft:4,'   ',NumberRight:4);
 gotoxy(65,3);write((SumLeft/Number):4:1,'   ',(SumRight/Number):4:1);
end;

procedure Shake(Strength:integer);
var i,dx,dy, NewX, NewY:integer;
    x,y:byte;
begin
 if Strength<=0 then exit;
 for i:=1 to Strength do
 begin
  ChancePlace(x,y);
  ChanceDirection(dx,dy);
  NewX:=x+dx;
  NewY:=y+dy;
  if (NewX in [1..MaxCell]) and (NewY in [1..MaxCell]) then
  begin
   if Board[x,y]>0 then
   begin
    dec(Board[x,y]);
    inc(Board[NewX,NewY]);
   end;
  end;
 end;
end;

begin
 clrscr;
 Init;
 repeat
  Drawing;
  Shake(StrengthOfEnergy);
 until keypressed;
end.
