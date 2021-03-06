function [mechanizm] = GenerujProblem()
%GenerujProblem funkcja generuj�ca z danych wyjsciowych elementy do
%analizy w oparciu o og�lny rysunek problemu. Wykorzystuje og�lne podej�cie
%do rozwi�zywania problem�w 2D
punkty = [GenPun('O',0.0,0.0);GenPun('H',0.4,-0.2);GenPun('N',0.1,-0.8),
GenPun('M',1.9,-1.4);GenPun('G',1.6,0.4);GenPun('D',2.2,-0.4);GenPun('C',2.5,-1.4);
GenPun('B',2.9,-1.1);GenPun('A',2.9,-1.9);GenPun('K',3.4,-1.9);
GenPun('c1',1.65,-0.85);GenPun('c2',2.15,-0.50);GenPun('c3',3.05,-1.60);
GenPun('c4',2.70,-1.25);GenPun('c5',0.55,-0.95);GenPun('c6',1.45,-1.25);
GenPun('c7',0.70,-0.05);GenPun('c8',1.30,0.25);GenPun('Q',1.0,0.1);
GenPun('W',1.0,-1.1)];

mechanizm.czlony = [GenCzlon('CZL1','c1',['O','D','A','M'],punkty,0);
GenCzlon('CZL2','c2',['G','D','C'],punkty,1);GenCzlon('CZL3','c3',['A','B','K'],punkty,2);
GenCzlon('CZL4','c4',['B','C'],punkty,3);GenCzlon('CZL5','c5',['N','W'],punkty,4);
GenCzlon('CZL6','c6',['M','W'],punkty,5);GenCzlon('CZL7','c7',['H','Q'],punkty,6);
GenCzlon('CZL8','c8',['G','Q'],punkty,7)];

%f1 = @(t)-sqrt(1.8*1.8+0.6*0.6)+0.5*cos(2*t)-0.5;
f1 = @(t)-sqrt(1.8*1.8+0.6*0.6)-0.15*sin(t);
f2 = @(t)-sqrt(1.2*1.2+0.6*0.6)-0.15*sin(2*pi*t);

mechanizm.wiezyilosc = 0;
mechanizm.liczbamonitorow = 0;

mechanizm = DodajWiez(mechanizm,'mocowanie','CZL1','O','','',@(t)0);
mechanizm = DodajWiez(mechanizm,'mocowanie','CZL5','N','','',@(t)0);
mechanizm = DodajWiez(mechanizm,'mocowanie','CZL7','H','','',@(t)0);
mechanizm = DodajWiez(mechanizm,'postepowa','CZL7','H','CZL8','G',@(t)0);
mechanizm = DodajWiez(mechanizm,'przemieszczenie','CZL7','H','CZL8','G',f2);
mechanizm = DodajWiez(mechanizm,'postepowa','CZL5','N','CZL6','M',@(t)0);
mechanizm = DodajWiez(mechanizm,'przemieszczenie','CZL5','N','CZL6','M',f1);
mechanizm = DodajWiez(mechanizm,'obrotowa','CZL8','G','CZL2','G',@(t)0);
mechanizm = DodajWiez(mechanizm,'obrotowa','CZL2','D','CZL1','D',@(t)0);
mechanizm = DodajWiez(mechanizm,'obrotowa','CZL2','C','CZL4','C',@(t)0);
mechanizm = DodajWiez(mechanizm,'obrotowa','CZL4','B','CZL3','B',@(t)0);
mechanizm = DodajWiez(mechanizm,'obrotowa','CZL3','A','CZL1','A',@(t)0);
mechanizm = DodajWiez(mechanizm,'obrotowa','CZL1','M','CZL6','M',@(t)0);
end

