with Liste_Generique;
with Ada.Integer_Text_IO, Ada.Text_IO; 
use Ada.Integer_Text_IO, Ada.Text_IO;


generic
    type Etat is private;
    type Coup is private;
    type Joueur is private;
    
    
    -- Nom affichable du Joueur1
    Nom_Joueur1 : String;
    -- Nom affichable du Joueur2   
    Nom_Joueur2 : String;
    -- Calcule l'etat suivant en appliquant le coup
    -- with function Etat_Suivant(E : Etat; C : Coup) return Etat;
    with function Etat_Suivant(E : in out Etat; C : in Coup) return Etat;
    -- Indique si l'etat courant est gagnant pour le joueur J
    -- with function Est_Gagnant(E : Etat; J : Joueur) return Boolean;
    with function Est_Gagnant(E : Etat; J : in Joueur) return Boolean;
    -- Indique si l'etat courant est un status quo (match nul)
    with function Est_Nul(E : Etat) return Boolean; 
    -- Fonction d'affichage de l'etat courant du jeu
    with procedure Affiche_Jeu(E : Etat);
    -- Affiche a l'ecran le coup passe en parametre
    with procedure Affiche_Coup(C : Coup);   
    -- Retourne le prochaine coup joue par le joueur1
    -- with function Coup_Joueur1(E : Etat) return Coup;
     with function Coup_Joueur1(E : in Etat) return Coup;
    -- Retourne le prochaine coup joue par le joueur2   
    --  with function Coup_Joueur2(E : Etat) return Coup;  
     with function Coup_Joueur2(E : in Etat) return Coup;
     
     ---- Redefinition de la fonction Adversaire ----
     with function Adversaire(E : in Etat; J : in Joueur) return Joueur;
     with function GetJoueur1(E : in Etat) return Joueur;
     
     
     with function Choix_Coup(E : in out Etat; J : in Joueur) return Coup;
     
     with function Eval(E : Etat ; J : Joueur) return Integer;
     

package Partie is
   
   Choix : Integer;
   Choix2 : String(1 .. 3);

    -- Joue une partie. 
    -- E : Etat initial
    -- J : Joueur qui commence
    -- procedure Joue_Partie(E : in out Etat; J : in Joueur);
   procedure Joue_Partie(E : in out Etat; J : in Joueur);
end Partie;
