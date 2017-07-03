---- 
----
---- Ce fichier n'est pas utilise, nous avons utilise "test_partie.adb" 
----
----

with Ada.Text_IO; 
with Ada.Integer_Text_IO;
with Puissance4;
with Participant;
with Partie;
with Liste_Generique;
with Moteur_Jeu;

use Ada.Text_IO;
use Ada.Integer_Text_IO;
use Participant;

procedure Main2Joueurs is
   
   package MyPuissance4 is new Puissance4(3,3,3);
   
   -- definition d'une partie entre un humain en Joueur 1 et un humain en Joueur 2
   package MyPartie is new Partie(MyPuissance4.Etat,
				  MyPuissance4.Coup
				   ,MyPuissance4.Joueur,
				  
				    
				  "Pierre",
				  "Paul",
				  MyPuissance4.Etat_Suivant,
				  MyPuissance4.Est_Gagnant,
				  MyPuissance4.Est_Nul,
				  MyPuissance4.Affiche_Jeu,
				  MyPuissance4.Affiche_Coup,
				  MyPuissance4.Coup_Joueur1,
				  MyPuissance4.Coup_Joueur2,
				  MyPuissance4.Adversaire,
				  MyPuissance4.GetJoueur1);
   use MyPartie;
   
     P: MyPuissance4.Etat := MyPuissance4.New_Etat;
   
   package Game_Motor is new Moteur_Jeu(MyPuissance4.Etat, MyPuissance4.Coup,  MyPuissance4.Etat_Suivant,  MyPuissance4.Est_Gagnant,  MyPuissance4.Est_Nul,  MyPuissance4.GetJoueur1,  MyPuissance4.Affiche_Coup,  MyPuissance4.Coups_Possibles,  MyPuissance4.Eval, 3,  MyPuissance4.GetJoueur1(P));
   use Game_Motor;
   
 

begin
   Put_Line("Puissance 4");
   Put_Line("");
   Put_Line("Joueur 1 : X"); 
   Put_Line("Joueur 2 : O");
   
  -- P := MyPuissance4.New_Etat;
   
   Joue_Partie(P, MyPuissance4.GetJoueur1(P));
end Main2Joueurs;
