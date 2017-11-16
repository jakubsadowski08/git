// Generator pseudolosowy Park-Miller
// Data:   18.04.2008
// (C)2012 mgr Jerzy Wa³aszek
//----------------------------------

program prg;

uses SysUtils,DateUtils;

var x0 : longword;

// Generuje liczby pseudolosowe
//-----------------------------
function PM_RNG : longword;
var
  xlo,xhi : longword;
begin
  xlo := 16807 * (x0 and $ffff);
  xhi := 16807 * (x0 shr 16);
  inc(xlo,(xhi and $7fff) shl 16);
  inc(xlo,xhi shr 15);
  if xlo > $7fffffff then dec(xlo,$7fffffff);
  x0 := xlo;
  PM_RNG := xlo;
end;
function RNG : longword;
var
  xlo,xhi : longword;
begin
  xlo := 16807 * (x0 and $ffff);
  xhi := 16807 * (x0 shr 16);
  inc(xlo,(xhi and $7fff) shl 16);
  inc(xlo,xhi shr 15);
  if xlo > $7fffffff then dec(xlo,$7fffffff);
  x0 := xlo;
  PM_RNG := xlo;
end;

// Ustawia losowe x0
//------------------
procedure Uprzypadkowij;
var
  t  : TDateTime;
begin
  repeat
    t  := Now;
    x0 := HourOf(t);
    x0 := x0 *   60 + MinuteOf(t);
    x0 := x0 *   60 + SecondOf(t);
    x0 := x0 * 1000 + MillisecondOf(t);
  until x0 <> 0;  
end;

var
  a,b,n,i : longint;
begin
  readln(a,b,n);
  Uprzypadkowij;
  for i := 1 to n do write(a + PM_RNG mod (b - a + 1),' ');
  writeln;
end. 

Code::Blocks

// Generator pseudolosowy Park-Miller
// Data:   18.04.2008
// (C)2012 mgr Jerzy Wa³aszek
//----------------------------------

#include <iostream>

using namespace std;

unsigned int x0;

// Generuje liczby pseudolosowe
//-----------------------------
unsigned int PM_RNG()
{
  unsigned int xlo,xhi;

  xlo = 16807 * (x0 & 0xffff);
  xhi = 16807 * (x0 >> 16);
  xlo += (xhi & 0x7fff) << 16;
  xlo += xhi >> 15;
  if(xlo > 0x7fffffff) xlo -= 0x7fffffff;
  return (x0 = xlo);
}

// Ustawia losowe x0
//------------------
void Uprzypadkowij()
{
  do x0 = (unsigned int) time(NULL); while(!x0);
}

int main()
{
  unsigned int a,b,n,i;

  cin >> a >> b >> n;
  Uprzypadkowij();
  for(i = 1; i <= n; i++) cout << (a + PM_RNG() % (b - a + 1)) << " ";
  cout << endl;
  return 0;
} 