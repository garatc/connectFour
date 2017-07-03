
with Ada.Integer_Text_IO, Ada.Text_IO, Liste_Generique; 
use Ada.Integer_Text_IO, Ada.Text_IO;

generic
  
   
   HAUTEUR : Integer;
   LARGEUR : Integer;
   ALIGNEMENT : Integer;
  
package Puissance4 is
       
   
   type Etat is private;
   
   
   ---- Un joueur est une chaine de caractere, et un symbole ---- 
    type Joueur is record
      Nom : String(1 .. 8);   
      Symbole : Character;
   end record;
   
    
    ---- Un coup est un joueur, et un numero de colonne ----
   type Coup is record 
      Player : Joueur;
      Numero_Colonne : Integer;
   end record;
   
   ---- La matrice qui va servir a la definition d'un etat ---- 
   type Matrice is array(Positive range <>, Positive range <>) of Character;

    -- Fonction d'affichage de l'etat courant du jeu
     procedure Affiche_Jeu(E : in Etat);
    -- Affiche a l'ecran le coup passe en parametre
     procedure Affiche_Coup(C : in Coup); 
     
     function Etat_Suivant(E : in out Etat; C : in Coup) return Etat;
     
     ---- Initialisation d'un etat ----
     function New_Etat return Etat;
     
     
     
      function GetJoueur1(E : in Etat) return Joueur;
     
     function Adversaire(E : in Etat; J : in Joueur) return Joueur;
     
     function Coup_Joueur1(E : in Etat) return Coup; 
     function Coup_Joueur2(E : in Etat) return Coup;
     
     
     ---- Les fonctions permettant de determiner s'il y a un alignement ----
     
     function Alignement_Ligne(E : in Etat; C : Character; I : Integer) return Boolean;
     
     function Alignement_Colonne(E : in Etat; C : Character; J : Integer) return Boolean;
     
    function Alignement_Diagonales(E : in Etat; C : Character) return Boolean;
    
    
    
    
    
    function Est_Gagnant(E : in Etat; J : in Joueur) return Boolean;
    function Est_Nul(E : in Etat) return Boolean;
    
    
    ---- Les fonctions permettant d'evaluer la situation sur les lignes, colonnes et diagonales, pour l'eval statique ----
    
     function Eval_Ligne(E : in Etat; C : Character; I : Integer; A : Integer) return Integer;
     function Eval_Diagonales(E : in Etat; C : Character; A : Integer) return Integer;
     function Eval_Colonne(E : in Etat; C : Character; J : Integer; A : Integer) return Integer;
     
     
     
       
      package Liste_Coups is new Liste_Generique(Coup,Affiche_Coup);
      use Liste_Coups;
       
      function Eval(E : Etat; J : Joueur) return Integer;
  
      function Coups_Possibles(E : Etat; J : Joueur) return Liste_Coups.Liste;
     

private     

   ---- Un etat est un plateau de jeu (une matrice Hauteur*Largeur), et deux joueurs ----
   
   type Etat is record
      Plateau : Matrice(1 .. HAUTEUR, 1 .. LARGEUR);
      Joueur1 : Joueur;
      Joueur2 : Joueur;
   end record;
   

end Puissance4;
