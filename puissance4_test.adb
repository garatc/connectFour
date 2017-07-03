with Ada.Integer_Text_IO, Ada.Text_IO, Puissance4, Liste_Generique;
use Ada.Integer_Text_IO, Ada.Text_IO;

procedure Puissance4_Test is 
   package Puissance4_3_3 is new Puissance4(3,3,3);
   use Puissance4_3_3;
   
   
   Robert : Etat;
   C : Coup;
   L : Liste_Coups.Liste := Liste_Coups.Creer_Liste;
  -- Coup : Integer := 0;
  -- Roger : array (0 .. 9) of Integer;
begin
   Robert := New_Etat;
  -- Robert(0) := 4;
  -- for I in 1 .. 9 loop
    --  E(0) := 5;
    --end loop;
  -- Roger(0) := 5;
  -- Put(Roger(0));
   
   C := Coup_Joueur1(Robert);
   Robert := Etat_Suivant(Robert, C);
   Affiche_Jeu(Robert);
   Affiche_Coup(C);
   
   C := Coup_Joueur1(Robert);
   Robert := Etat_Suivant(Robert, C);
   Affiche_Jeu(Robert);
   Affiche_Coup(C);
   
   C := Coup_Joueur1(Robert);
   Robert := Etat_Suivant(Robert, C);
   Affiche_Jeu(Robert);
   Affiche_Coup(C);
   
   L := Coups_Possibles(Robert,GetJoueur1(Robert));
   
   Liste_Coups.Affiche_Liste(L);
   
  -- C := Coup_Joueur1(Robert);
  -- Robert := Etat_Suivant(Robert,C);
   --Affiche_Jeu(Robert);
   --Affiche_Coup(C);

   
   --Coup := Coup_Joueur1(Robert);
   
   --Put(Boolean'Image(Alignement_Ligne(Robert,'X',3)));
   --Put(Boolean'Image(Alignement_Colonne(Robert,'X',1)));
   --Put(Boolean'Image(Alignement_Diagonales(Robert,'X')));
   --Put(Boolean'Image(Est_Gagnant(Robert,'X')));
   
  -- Put_Line("Eval ligne 2");
   --Put(Integer'Image(Eval_Ligne(Robert,'X',2)));
   --New_Line;
   
 --  Put_Line("Eval ligne 3");
  -- Put(Integer'Image(Eval_Ligne(Robert,'X',3)));
   --New_Line;
   
  -- Put_Line("Eval colonne 1");
   --Put(Integer'Image(Eval_Colonne(Robert,'X',1)));
   --New_Line;
   
   --Put_Line("Eval colonne 2");
   --Put(Integer'Image(Eval_Colonne(Robert,'X',2)));
   --New_Line;
   
  -- Put_Line("Eval colonne 3");
   --Put(Integer'Image(Eval_Colonne(Robert,'X',3)));
   --New_Line;
   
   --Put_Line("Eval diagonales");
   --Put(Integer'Image(Eval_Diagonales(Robert,'X')));
   --New_Line;
   
   --Put_Line("Alignement diagonales");
   --Put(Boolean'Image(Alignement_Diagonales(Robert,'X')));
   --New_Line;
   
  -- Put_Line("Eval totale");
  -- Put(Integer'Image(Eval(Robert)));
  -- New_Line;
   
   
end Puissance4_Test;
