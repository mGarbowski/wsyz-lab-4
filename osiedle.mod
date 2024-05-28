set OPERACJE;
set POPRZEDNIKI within {OPERACJE cross OPERACJE};

param czas_nominalny {OPERACJE} >= 0;
param czas_minimalny {OPERACJE} >= 0;

param liczba_pracownikow {OPERACJE} >= 0;
param K integer >= 0;
param koszt_dnia_nadgodzin integer >= 0;


var calkowity_czas integer >= 0;
var rozpoczecie {OPERACJE} integer >= 0;
var czas_faktyczny {OPERACJE} integer >= 0;
var czas_skrocony {OPERACJE} integer >= 0;

subject to wykorzystanie_srodkow:
	K = sum {o in OPERACJE} czas_skrocony[o] * liczba_pracownikow[o] * koszt_dnia_nadgodzin;
	
	
subject to c_czas_minimalny {o in OPERACJE}:
	czas_faktyczny[o] >= czas_minimalny[o];
	
	
subject to skrocenie_czasu {o in OPERACJE}:
	czas_faktyczny[o] = czas_nominalny[o] - czas_skrocony[o];	

subject to poprzedzanie {(p, n) in POPRZEDNIKI}:
	rozpoczecie[n] >= rozpoczecie[p] + czas_faktyczny[p];

subject to c_calkowity_czas {o in OPERACJE}:
	calkowity_czas >= rozpoczecie[o] + czas_faktyczny[o];
	
minimize minimalny_czas_trwania:
	calkowity_czas;
	