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

%%%% SEGUNDA ENTREGA %%%%

% personaje(Nombre, Ocupacion)
personaje(pumkin,     ladron([estacionesDeServicio, licorerias])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).
personaje(bernardo,   mafioso(cerebro)).
personaje(bianca,     actriz([elPadrino1])).
personaje(elVendedor, vender([humo, iphone])).
personaje(jimmie,     vender([auto])).

% encargo(Solicitante, Encargado, Tarea). 
% las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(bernardo, vincent, buscar(jules, fuerteApache)).
encargo(bernardo, winston, buscar(jules, sanMartin)).
encargo(bernardo, winston, buscar(jules, lugano)).

%%%% amigos %%%%
amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

%%%%      Punto 1     %%%%

ocupacionPeligrosa(mafioso(maton)).
ocupacionPeligrosa(ladron(LugaresDondeRoba)) :- member(licorerias,LugaresDondeRoba). 

esPeligroso(Persona) :- personaje(Persona,Ocupacion), ocupacionPeligrosa(Ocupacion).
esPeligroso(Persona) :- trabajaPara(Jefe,Persona), esPeligroso(Jefe).

%%%%      Punto 2     %%%%

esPersona(Persona) :- personaje(Persona,_).

sonAmigos(UnaPersona,OtraPersona) :- amigo(UnaPersona,OtraPersona).
sonAmigos(UnaPersona,OtraPersona) :- amigo(OtraPersona,UnaPersona).

relacionLaboral(UnaPersona,OtraPersona) :- trabajaPara(UnaPersona,OtraPersona).
relacionLaboral(UnaPersona,OtraPersona) :- trabajaPara(OtraPersona,UnaPersona).

loTieneCerca(UnaPersona,OtraPersona) :- sonAmigos(UnaPersona,OtraPersona).
loTieneCerca(UnaPersona,OtraPersona) :- relacionLaboral(UnaPersona,OtraPersona).

losQueTieneCerca(Persona,Cercanos) :- esPersona(Persona),
                                      findall(Alguien, loTieneCerca(Persona,Alguien), Cercanos).

tieneAlMenosUnoCerca(Persona) :- loTieneCerca(Persona,_).

leDaUnEncargo(Alguien,Otro) :- encargo(Alguien,Otro,_).

sanCayetano(Persona) :- tieneAlMenosUnoCerca(Persona),
                        forall(loTieneCerca(Persona,Cercano),leDaUnEncargo(Persona,Cercano)).

%%%%      Punto 3     %%%%

respetoOcupacional(actriz(Peliculas),Nivel) :- length(Peliculas,Nivel).
respetoOcupacional(mafioso(resuelveProblemas),10).
respetoOcupacional(mafioso(capo),20).

nivelRespeto(Persona,Nivel) :- personaje(Persona, Ocupacion),
                               respetoOcupacional(Ocupacion,Nivel).
                               
nivelRespeto(vincent,15).

%%%%      Punto 4     %%%%
esRespetable(Persona) :- nivelRespeto(Persona,Nivel),
						 Nivel >  9.
						 
losNoRespetables(NoRespetables) :- findall(Persona,(esPersona(Persona),not(esRespetable(Persona))),NoRespetables).

losRespetables(Respetables):- findall(Persona,esRespetable(Persona),Respetables).

respetabilidad(CantidadDeRespetables,CantidadDeNoRespetables) :- losRespetables(Respetables),
											 length(Respetables,CantidadDeRespetables),
											 losNoRespetables(NoRespetables),
											 length(NoRespetables,CantidadDeNoRespetables).

%%%%      Punto 5     %%%%

listaDeEncargos(Encargado,ListaDeEncargos) :- esPersona(Encargado),
										      findall(Encargo,encargo(_,Encargado,Encargo),ListaDeEncargos).

cantidadDeEncargos(Encargado,CantidadDeEncargos) :- listaDeEncargos(Encargado,ListaDeEncargos),
													length(ListaDeEncargos,CantidadDeEncargos).

esMasAtareado(Persona,Persona2) :- cantidadDeEncargos(Persona,CantidadDeEncargos),
								   cantidadDeEncargos(Persona2,CantidadDeEncargos2),
								   CantidadDeEncargos > CantidadDeEncargos2.
								   
sonDistintasPersonas(Persona,Persona2) :- esPersona(Persona),
										  esPersona(Persona2),
										  Persona \= Persona2.

masAtareado(Persona) :- esPersona(Persona),
						forall(sonDistintasPersonas(Persona,Persona2),esMasAtareado(Persona,Persona2)).
