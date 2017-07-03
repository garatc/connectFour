with Ada.Integer_Text_IO, Ada.Text_IO, Puissance4, Partie, Moteur_Jeu, Liste_Generique;
use Ada.Integer_Text_IO, Ada.Text_IO;

procedure Beat_Computer is 
   
   ---- Instanciation du puissance4 classique ----
   package P4 is new Puissance4(6,7,4);
   use P4;
   
   E : Etat := New_Etat;
  
   ---- Instanciation du moteur de jeu, qui utilise les fonctions/procedures de P4, de meme que la liste de coup instanciee dans P4  ----
     package Game_Motor is new Moteur_Jeu(P4.Etat,P4.Coup,P4.Joueur, P4.Etat_Suivant, P4.Est_Gagnant, P4.Est_Nul, P4.GetJoueur1, P4.Affiche_Coup, P4.Liste_Coups, P4.Coups_Possibles, P4.Eval,5 , P4.GetJoueur1(E),P4.Adversaire);
     use Game_Motor;
     
     
     ---- Instanciation de la partie entre Magnus Carlsen et Sergey Karjakin ----
     package Partie_Puissance4 is new Partie(Etat, Coup, Joueur, "Carlsen", "Karjakin",Etat_Suivant,Est_Gagnant,Est_Nul,Affiche_Jeu,Affiche_Coup,Coup_Joueur1,Coup_Joueur2,Adversaire,GetJoueur1,Game_Motor.Choix_Coup,Eval);
  use Partie_Puissance4;
   
begin
   
   ---- Jouons un peu ----
   Joue_Partie(E,GetJoueur1(E));
   
   
   
end Beat_Computer;
