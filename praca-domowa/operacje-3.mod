set OPERACJE;
set POPRZEDNIKI within {OPERACJE cross OPERACJE};

param czas_nominalny {OPERACJE} >= 0;
param czas_minimalny {OPERACJE} >= 0;
param koszt_skrocenia {OPERACJE} >= 0;
param dostepne_srodki integer >= 0;

var calkowity_czas integer >= 0;
var rozpoczecie {OPERACJE} integer >= 0;
var czas_faktyczny {OPERACJE} integer >= 0;
var czas_skrocony {OPERACJE} integer >= 0;
var wykorzystane_srodki {OPERACJE} integer >= 0;

subject to ograniczone_srodki:
	sum {o in OPERACJE} wykorzystane_srodki[o] <= dostepne_srodki;
	
subject to c_czas_minimalny {o in OPERACJE}:
	czas_faktyczny[o] >= czas_minimalny[o];
	
subject to skrocenie_czasu {o in OPERACJE}:
	czas_faktyczny[o] = czas_nominalny[o] - czas_skrocony[o];
	
subject to c_koszt_skrocenia {o in OPERACJE}:
	wykorzystane_srodki[o] = czas_skrocony[o] * koszt_skrocenia[o];
	
subject to poprzedzanie {(p, n) in POPRZEDNIKI}:
	rozpoczecie[n] >= rozpoczecie[p] + czas_faktyczny[p];

subject to c_calkowity_czas {o in OPERACJE}:
	calkowity_czas >= rozpoczecie[o] + czas_faktyczny[o];
	
minimize minimalny_czas_trwania:
	calkowity_czas;
	