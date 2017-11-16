// Generator Mersenne Twister
// Data   : 16.04.2008
// (C)2012 mgr Jerzy Wa³aszek
//---------------------------

#include <iostream>

using namespace std;

typedef unsigned long long ulong;

unsigned int MT[624];
int mti = 0;

// Inicjuje MT[]
//--------------
void InicjujMT(unsigned int x0)
{
  ulong x;

  MT[0] = x0;
  for(int i = 1; i < 623; i++)
  {
    x = MT[i-1];
    x = (23023 * x) & 0xffffffffull;
    x = (    3 * x) & 0xffffffffull;
    MT[i] = x;
  }
}

// Inicjuje MT wartoœciami losowymi
//---------------------------------
void UprzypadkowijMT()
{
  InicjujMT((unsigned int)time(NULL));
}

// Generator Mersenne Twister
//--------------------------
unsigned int MersenneTwister()
{
  const unsigned int MA[] = {0,0x9908b0df};
  long int y;
  int i1,i397;

  i1      = mti +   1; if(  i1 > 623) i1 = 0;
  i397    = mti + 397; if(i397 > 623) i397 -= 624;
  y       = (MT[mti] & 0x80000000) | (MT[i1] & 0x7fffffff);
  MT[mti] = MT[i397] ^ (y >> 1) ^ MA[y & 1];
  y       = MT[mti];
  y       ^=  y >> 11;
  y       ^= (y <<  7) & 0x9d2c5680;
  y       ^= (y << 15) & 0xefc60000;
  y       ^=  y >> 18;
  mti     = i1;
  return y;
}

int main()
{
  int a,b,i,n;

  UprzypadkowijMT();
  cin >> a >> b >> n;
  for(i = 1; i <= n; i++) cout << (a + (MersenneTwister() % (b - a + 1))) << " ";
  cout << endl << endl;

  return 0;
} 