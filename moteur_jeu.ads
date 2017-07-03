--with Participant; use Participant; 
with Liste_Generique;
with Ada.Text_IO;
with Puissance4;
with Ada.Numerics.Discrete_Random; ---- Le package a utiliser pour les nombres aleatoires ----

generic
    type Etat is private;
    type Coup is private;
    type Joueur is private;
    

    -- Calcule l'etat suivant en appliquant le coup
    with function Etat_Suivant(E : in out Etat; C : in Coup) return Etat;
    -- Indique si l'etat courant est gagnant pour J
    with function Est_Gagnant(E : Etat; J : Joueur) return Boolean; 
    -- Indique si l'etat courant est un status quo (match nul)
    with function Est_Nul(E : Etat) return Boolean; 
    
    ---- Retourne le Joueur1 ----
    with function GetJoueur1(E : in Etat) return Joueur;

    -- Affiche a l'ecran le coup passe en parametre
    with procedure Affiche_Coup(C : in Coup);
    -- Implantation d'un package de liste de coups
    with package Liste_Coups is new Liste_Generique(Coup,Affiche_Coup);
   use Liste_Coups;
    

    -- Retourne la liste des coups possibles pour J a partir de l'etat 
    with function Coups_Possibles(E : Etat; J : Joueur) return Liste_Coups.Liste; 
    -- Evaluation statique du jeu du point de vue de l'ordinateur
    with function Eval(E : Etat ; J : Joueur) return Integer;   
    -- Profondeur de recherche du coup
    Pro : Natural;
    -- Indique le joueur interprete par le moteur
    JoueurMoteur : Joueur;
	
	
    with function Adversaire(E : in Etat; J : in Joueur) return Joueur;
    
package Moteur_Jeu is
   
   ---- Instanciation du package pour les nombres aleatoires ----
   
   type Numero is range 1 .. 100;
   package Aleatoire is new Ada.Numerics.Discrete_Random (Numero);
   use Aleatoire;
   
   A : Numero;
   G : Generator;
   
   
   
    -- Choix du prochain coup par l'ordinateur. 
    -- E : l'etat actuel du jeu;
    -- P : profondeur a laquelle la selection doit s'effectuer
    ---- J : Joueur qui realise le coup
    function Choix_Coup(E : in out Etat; J : in Joueur) return Coup;
   
private 
    -- Evaluation d'un coup a partir d'un etat donne
    -- E : Etat courant
    -- P : profondeur a laquelle cette evaluation doit etre realisee
    -- C : Coup a evaluer
    -- J : Joueur qui realise le coup
    function Eval_Min_Max(E : in out Etat; P : in out Natural; J : in Joueur)
			 return Integer;
    
  
end Moteur_Jeu;
