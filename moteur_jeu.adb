with Liste_Generique;
with Ada.Text_IO;
with Puissance4;
with Partie;
with Ada.Integer_Text_IO;
use Ada.Text_IO;
use Ada.Integer_Text_IO;

package body Moteur_Jeu is
   
   
   function Eval_Min_Max(E : in out Etat; P : in out Natural; J : in Joueur) return Integer is
      Maxi : Integer := -9999;
      Stock : Integer;
      It : Iterateur;
      L : Liste := Creer_Liste;
      Stock_Etat : Etat;
      Profondeur : Integer;
   begin 
      
      ---- Si on est arrive sur une feuille ou un etat gagnant ----
      
      if (P = 0) then
	 return Eval(E,J); 
	 
      elsif Est_Gagnant(E,J) then
	 return 2000;
            
      elsif Est_Gagnant(E,Adversaire(E,J)) then
	 return -2000;
            
      elsif Est_Nul(E) then
	 return 0;
      end if;
      
      ---- L contient alors tous les coups possibles pour le joueur J dans l'etat donne ----
      
      L := Coups_Possibles(E,J);
      It := Creer_Iterateur(L);
      
      ---- On parcourt alors cette liste de coups et on simule chaque coup ----
      
      while A_Suivant(It) loop
	 
       	 Stock_Etat := E; ---- Sauvegarde de l'etat courant ----
	 E := Etat_Suivant(E,Element_Courant(It));
	 Profondeur := P - 1;
	 
	 ---- Appel de la fonction, cette fois-ci pour minimiser le score de l'adversaire ----
	 Stock := -Eval_Min_Max(E,Profondeur,Adversaire(E,J));
	 

	 if (Stock > Maxi) then
	    Maxi := Stock;
	 end if;
	 
	 E := Stock_Etat;
	 Suivant(It);
      end loop;
      
       Libere_Liste(L);

      
      return Maxi;
   end Eval_Min_Max;
   
  
   
    function Choix_Coup(E : in out  Etat; J : in Joueur) return Coup is
      Maxi : Integer := -9999;
      It : Iterateur;
      L : Liste := Creer_Liste;
      Stock : Integer;
      Stock_Etat : Etat;
      C : Coup;
      P : Integer := Pro;
     
   begin
      
      L := Coups_Possibles(E,J);
      It := Creer_Iterateur(L);
      
      ---- On initialise le generateur ----
      
      Reset(G);
      A := Random(G);
      
      while A_Suivant(It) loop
	
	 Stock_Etat := E;
	 E := Etat_Suivant(E,Element_Courant(It));
	 
	 Stock := -Eval_Min_Max(E,P,Adversaire(E,J));
	
	 if ((Stock > Maxi) or ((Stock = Maxi) and then (A mod 3 = 0))) then
	    Maxi := Stock;
	    C := Element_Courant(It);
	    ---- Cette fois ci on stocke le meilleur coup ----
	 end if;
	 
	 E := Stock_Etat;
	 Suivant(It);
      end loop;
      
      Libere_Liste(L);
      
      return C;
   end Choix_Coup;
   
   
end Moteur_Jeu;

