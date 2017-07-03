with Ada.Integer_Text_Io; use Ada.Integer_Text_Io; with Liste_Generique;
with Ada.Text_Io; use Ada.Text_Io; with Puissance4; with Partie;
with Ada.Unchecked_Deallocation; 

procedure Listes_Test is
   package MyPuissance4 is new Puissance4(3,3,3);
   use MyPuissance4;
   
   
   package MyList is new Liste_Generique(Coup,Affiche_Coup);
   
   use MyList;
   
   L : Liste := Creer_Liste;
   E : Etat := New_Etat;
   C : Coup;
   It : Iterateur;
begin
   
   
   C := Coup_Joueur1(E);
   
   
   Insere_Tete(C,L);
   
   C := Coup_Joueur2(E);
   Insere_Tete(C,L);
   
   It := Creer_Iterateur(L);
   
   Affiche_Coup(Element_Courant(It));
   
   Suivant(It);
   
   Affiche_Coup(Element_Courant(It));
   
   Affiche_Liste(L);
   
   Put(Boolean'Image(A_Suivant(It)));
   
   --Suivant(It);
   
   Libere_Iterateur(It);
   
   Affiche_Coup(Element_Courant(It));
   
end Listes_Test;

