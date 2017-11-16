// Test pierwszoœci Fermata
// Data   : 5.04.2008
// (C)2012 mgr Jerzy Wa³aszek
//----------------------------

program prg;

// 64 bitowy generator pseudolosowy
//---------------------------------
function Losuj(a,b : qword) : qword;

var w : qword;
    i : integer;
begin
  for i := 1 to 8 do
  begin
    w := w shl 8;
    w := w and random(256);
  end;
  Losuj := a + (w mod (b - a));
end;

// Funkcja oblicza NWD
//--------------------
function NWD(a,b : qword) : qword;

var t : qword;

begin
  while b <> 0 do
  begin
    t := b;
    b := a mod b;
    a := t;
  end;
  NWD := a;
end;

// Funkcja mno¿y a i b mod n
//--------------------------
function MnozModulo(a,b,n : qword) : qword;

var m,w : qword;

begin
  w := 0; m := 1;
  while m <> 0 do
  begin
    if b and m <> 0 then w := (w + a) mod n;
    a := (a shl 1) mod n;
    m := m shl 1;
  end;
  MnozModulo := w;
end;

// Funkcja oblicza a^e mod n
//--------------------------
function PotegujModulo(a,e,n : qword) : qword;

var m,p,w : qword;

begin
  p := a; w := 1; m := 1;
  while m <> 0 do
  begin
    if e and m <> 0 then w := MnozModulo(w,p,n);
    p := MnozModulo(p,p,n);
    m := m shl 1;
  end;
  PotegujModulo := w;
end;

// Tablica pocz¹tkowych 169 liczb pierwszych
//------------------------------------------
const lp : array[0..168] of integer = (
  2,  3,  5,  7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67,
 71, 73, 79, 83, 89, 97,101,103,107,109,113,127,131,137,139,149,151,157,163,
167,173,179,181,191,193,197,199,211,223,227,229,233,239,241,251,257,263,269,
271,277,281,283,293,307,311,313,317,331,337,347,349,353,359,367,373,379,383,
389,397,401,409,419,421,431,433,439,443,449,457,461,463,467,479,487,491,499,
503,509,521,523,541,547,557,563,569,571,577,587,593,599,601,607,613,617,619,
631,641,643,647,653,659,661,673,677,683,691,701,709,719,727,733,739,743,751,
757,761,769,773,787,797,809,811,821,823,827,829,839,853,857,859,863,877,881,
883,887,907,911,919,929,937,941,947,953,967,971,977,983,991,997,1009);

var p,a : qword;
    i : integer;
    t : boolean;
begin
  randomize;
  readln(p);
  t := true;
  for i := 0 to 168 do
    if (p <> lp[i]) and (p mod lp[i] = 0) then
    begin
      t := false; break;
    end;
  if t and (p > 1009) then
  begin
    for i := 1 to 10 do
    begin
      a := Losuj(2,p-1);
      if (NWD(p,a) <> 1) or (PotegujModulo(a,p-1,p) <> 1) then
      begin
        t := false; break;
      end;
    end;
  end;
  if t then writeln('TAK')
  else      writeln('NIE');
end. 