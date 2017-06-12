%%%%% PRIMERA ENTREGA %%%%%

% pareja(Persona,Persona)
pareja(marsellus,mia).
pareja(pumkin,honeyBunny).

% trabajaPara(Empleador,Empleado)
trabajaPara(marsellus,vincent).
trabajaPara(marsellus,jules).
trabajaPara(marsellus,winston).

%%%%      Punto 1     %%%%

saleCon(UnaPersona,OtraPersona) :- pareja(UnaPersona,OtraPersona).
saleCon(UnaPersona,OtraPersona) :- pareja(OtraPersona,UnaPersona).

%%%%      Punto 2     %%%%

pareja(bernardo,bianca).
pareja(bernardo,charo).

%% Como no se si Bianca es pareja de Demóstenes, no puedo afirmar algo que no sea cierto. No tiene sentido escribir algo que no es cierto en Prolog