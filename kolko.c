#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include<ctime.h>
#define TRUE 1
#define FALSE 0
#define N 4
//Jakub Sadowski
time_t tt;
char tablica[N*N];
int czy_unikatowa(char *tablica, int liczba)
{
	if (tablica[liczba] == 'o' || tablica[liczba] == 'x')
		return 0;
	else
		return 1;
}
int losowa()
{
	srand(time(&tt));
	return rand() % (N*N);
}
void domyslne_wartosci()
{
	int i;
	for (i = 0; i<N*N; i++)
	{
		tablica[i] = '|';
	}
}
int wczytaj_ruch_gracza()
{
	int ruch;
	printf("Podaj twoj ruch: (Od 0 do %d)", N*N - 1);
	scanf_s("%d", &ruch);
	return ruch;
}
void wypisz()
{
	int i = 0;
	for (i = 0; i<N*N; i++)
	{
		printf("%c", tablica[i]);
		if ((i + 1) % N == 0)
			printf("\n");
	}
}
void ruch_komputera(int a)
{
	while (TRUE)
	{
		if (czy_unikatowa(tablica, a))
		{
			tablica[a] = 'o';
			break;
		}
		a = losowa();
	}
}
int czy_gra_sie_skonczyla()
{
	int i, j;
	int x;
	int y;
	int x_pionowe = 0;
	int y_pionowe = 0;
	int tmp = 0;
	int tmp_2 = 0;
	int x_krzyz = 0;
	int y_krzyz = 0;
	int x_krzyz_2 = 0;
	int y_krzyz_2 = 0;
	for (i = 0; i<N; i++)
	{
		x = 0;
		y = 0;
		for (j = 0; j<N; j++)
		{
			if (tablica[N*i + j] == 'x')
			{
				if ((N*i + j) % (N + 1) == 0)
					x_krzyz++;
				if ((N*i + j) % (N - 1) == 0 && N*i + j != 0 && N*i + j != N)
					x_krzyz_2++;
				x++;
				if (x_pionowe == 0 && y == 0)
				{
					x_pionowe++;
					tmp = j;
				}
				else if (j ==tmp)
					x_pionowe++;
					
			}

			else if (tablica[N*i + j] == 'o')
			{
				if ((N*i + j) % (N +1) == 0)
					y_krzyz++;
				if ((N*i + j) % (N - 1) == 0 && N*i + j != 0 && N*i + j != N)
					y_krzyz_2++;
				y++;
				if (y_pionowe == 0 && i == 0)
				{
					y_pionowe++;
					tmp_2 = j;
				}
				else if (j == tmp_2)
					y_pionowe++;
			}
		}
		if (y == N || x == N)
			return FALSE;
	}
	if (y_pionowe == N || x_pionowe == N || x_krzyz == N || y_krzyz == N || x_krzyz_2 == N || y_krzyz_2 == N)
		return FALSE;
	return TRUE;
}
int main(void)
{
	int licznikRuchow = 0;
	int wczytaj;
	domyslne_wartosci();
	wypisz();
	while (czy_gra_sie_skonczyla())
	{
		wczytaj = wczytaj_ruch_gracza();
		if (czy_unikatowa(tablica, wczytaj))
		{
			tablica[wczytaj] = 'x';
			licznikRuchow++;
			if (licznikRuchow == N*N)
			{
				system("cls");
				wypisz();
				break;
			}
		}
		else {
			printf("juz tam cos jest ,podaj inna:");
			continue;
		}
		ruch_komputera(losowa());
		licznikRuchow++;
		system("cls");
		wypisz();
	}
	return 0;
}