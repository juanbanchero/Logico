%%%%% PRIMERA ENTREGA %%%%%

% pareja(Persona,Persona)
%% se agrega el punto 2 %%
%% Como no se si Bianca es pareja de Demóstenes, no puedo afirmar algo que no sea cierto. No tiene sentido escribir algo que no es cierto en Prolog
pareja(marsellus,mia).
pareja(pumkin,honeyBunny).
pareja(bernardo,bianca).
pareja(bernardo,charo).

% trabajaPara(Empleador,Empleado)
%% se agrega el punto 3 %%
trabajaPara(marsellus,vincent).
trabajaPara(marsellus,jules).
trabajaPara(marsellus,winston).
trabajaPara(Empleador,bernardo) :- trabajaPara(marsellus,Empleador), Empleador \= jules.
trabajaPara(Empleador,george) :- saleCon(bernardo,Empleador).


%%%%      Punto 1     %%%% 

saleCon(UnaPersona,OtraPersona) :- pareja(UnaPersona,OtraPersona).
saleCon(UnaPersona,OtraPersona) :- pareja(OtraPersona,UnaPersona).

%%%%      Punto 4     %%%% 
esFiel(Persona) :- saleCon(Persona,_),not(saleConMasDeUno(Persona)).

saleConMasDeUno(Persona) :- saleCon(Persona,OtraPersona), saleCon(Persona,OtraPersonaMas), OtraPersona \= OtraPersonaMas.

%%%%      Punto 5     %%%% 
acataOrden(Jefe,Empleado) :- trabajaPara(Jefe,Empleado).
acataOrden(Jefe,Empleado) :- trabajaPara(Jefe,Empleador),acataOrden(Empleador,Empleado).



