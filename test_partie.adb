with Ada.Integer_Text_IO, Ada.Text_IO, Puissance4, Partie;
use Ada.Integer_Text_IO, Ada.Text_IO;

procedure Test_Partie is 
   package Puissance4_3_3 is new Puissance4(3,3,3);
   use Puissance4_3_3;
   package Partie_Puissance4 is new Partie(Etat, Coup, Joueur, "Carlsen", "Karjakin",Etat_Suivant,Est_Gagnant,Est_Nul,Affiche_Jeu,Affiche_Coup,Coup_Joueur1,Coup_Joueur2,Adversaire,GetJoueur1);
   use Partie_Puissance4;
   
  
   
   E : Etat;
   
begin
   
   E := New_Etat;
   
   Joue_Partie(E,GetJoueur1(E));
   
   
   
end Test_Partie;
