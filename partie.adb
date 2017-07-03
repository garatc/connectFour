--with Liste_Generique, Participant;
--with Participant;
with Ada.Integer_Text_IO, Ada.Text_IO, Puissance4, Moteur_Jeu; 
use Ada.Integer_Text_IO, Ada.Text_IO;

--use Participant;

package body Partie is 
   
   
      
   
   procedure Joue_Partie(E : in out Etat ; J : in Joueur) is
      Kou : Coup;
      Gagnant : Boolean := False;
      
      	
   begin
      
      ---- Tant que le joueur n'est pas gagnant, que son adversaire ne l'est pas non plus, et qu'il n'y a pas nul, on continue ----
      Choix := 0;
      
      while ((not Est_Gagnant(E,J) or  Est_Nul(E)) and not Gagnant) loop
		  
	 if (Choix = 0) then 
	    
	    New_Line;
	    Put_Line("******************************* Bienvenue ! *******************************");
	    Put_Line("Vous etes sur le point de participer au championnat du monde de Puissance4.");
	    New_Line;
		Put_Line("-> Pour jouer avec le maître Carlsen contre le disciple Karjakin, tapez 1 ");
		Put_Line("-> Pour jouer avec le maître Carlsen contre ton ami Karjakin, tapez 2 ");
		Put_Line("-> Pour regarder les championnats de monde de Puissance4 entre le maître Carlsen et le disciple Karjakin, tapez 3 ");
		Get(Choix);
   
		if (Choix = 1) then
		   Put_Line("Qui commence? 'MOI' ou 'LUI' ?");
		   Get(Choix2);
	
		end if;
	end if;

	Put_Line(Nom_Joueur1);
	
	if (Choix2 = "MOI") then
	   
	   if ( (Choix = 1) or (Choix = 2) )then
	      Kou := Coup_Joueur1(E);
	   else
	      Kou := Choix_Coup(E,GetJoueur1(E));
	   end if;
	   
	   E := Etat_Suivant(E, Kou);
	
	   Put("Joueur1 ");
	   Affiche_Coup(Kou);
	   
	   ----	 Put("evaluation : " & Integer'Image(Eval(E))); ---- Si besoin d'avoir un apercu de l'eval statique ----
	   
	   New_Line;
	   
	   Affiche_Jeu(E);
	   
	end if;
	
	---- Meme principe que pour le while ----
	
	if ((not Est_Gagnant(E,Adversaire(E,J)) or (not Est_Nul(E))) and not Est_Gagnant(E,J)) then
	   
	   Put_Line(Nom_Joueur2);
	   Choix2 := "MOI";
	   
	   if ((Choix = 3 ) or (Choix = 1)) then
	      
	      Kou := Choix_Coup(E,Adversaire(E,GetJoueur1(E)));
	   else 
	      Kou := Coup_Joueur2(E);
	   end if;
	   
	   E := Etat_Suivant(E, Kou);
	   Put("Joueur2 ");
	   Affiche_Coup(Kou);
	   Affiche_Jeu(E);
	   
	   ---- Ce if n'est pas indispensable et pourrait etre remplace ----
	   if Est_Gagnant(E,Adversaire(E,J)) then
	      Gagnant := True;
	   end if ;
	   
	 end if;
	 
	 if Est_Gagnant(E,J) then
	    Put_Line(Nom_Joueur1 & " is unbeatable");
	 end if;
	 
	 if Gagnant then
	    ---- Petite reference de geek parce que quand meme, on est a l'ensimag cette annee ---- 
	    Put_Line(Nom_Joueur2 & " just did a monsterkill");
	 end if;
	 
      end loop;
end Joue_Partie;
  

   
end Partie;
