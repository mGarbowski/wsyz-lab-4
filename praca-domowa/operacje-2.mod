set OPERACJE;
set POPRZEDNIKI within {OPERACJE cross OPERACJE};

param czas_nominalny {OPERACJE} >= 0;
param czas_minimalny {OPERACJE} >= 0;
param koszt_skrocenia {OPERACJE} >= 0;
param dostepne_srodki >= 0;

var calkowity_czas >= 0;
var rozpoczecie {OPERACJE} >= 0;

subject to poprzedzanie {(p, n) in POPRZEDNIKI}:
	rozpoczecie[n] >= rozpoczecie[p] + czas_minimalny[p];

subject to c_calkowity_czas {o in OPERACJE}:
	calkowity_czas >= rozpoczecie[o] + czas_minimalny[o];
	
minimize minimalny_czas_trwania:
	calkowity_czas;
	