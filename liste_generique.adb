with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Unchecked_Deallocation;

package body Liste_Generique is

   type Cellule is record
		Val: Element;
		Suiv: Liste;
   end record;
   
   type Iterateur_Interne is record
     Courant : Liste;
   end record;
   

   
   procedure Liberer is new Ada.Unchecked_Deallocation (Cellule, Liste);
   
    -- Affichage de la liste, dans l'ordre de parcours
  procedure Affiche_Liste (L : in Liste) is
      Stock : Liste := L;
   begin
      while (Stock /= null) loop
	 Put(Stock.all.Val);
	 New_Line;
	 Stock := Stock.Suiv;
      end loop;
   end Affiche_Liste;
   

    -- Insertion d'un element V en tete de liste
    procedure Insere_Tete (V : in Element; L : in out Liste) is 
        Stock : Liste;
	begin
	   if (L = null) then
      	      L := new Cellule'(V,null);
	   else 
	      Stock := new Cellule'(V,L);
	      L := Stock;
	   end if;

	end Insere_Tete;
    
	  
      

    -- Vide la liste et libere toute la memoire utilisee
	procedure Libere_Liste(L : in out Liste) is
	   Stock : Liste := L;
	begin
	    Stock := L;
	   if (L.Suiv = null) then
	      Liberer(L);
	   else
	      while (Stock /= null) loop
		 Liberer(L);
		 Stock := Stock.Suiv;
		 L := Stock;
	      end loop;
	   end if;
	end Libere_Liste;
	

    -- Creation de la liste vide
    function Creer_Liste return Liste is
	begin
	   return null;
	end Creer_Liste;

    -- Cree un nouvel iterateur 
	function Creer_Iterateur (L : Liste) return Iterateur is
	   It : Iterateur;
	begin
	   It := new Iterateur_Interne;
	   It.Courant := L;
	   return It;
	end Creer_Iterateur;
	

    -- Liberation d'un iterateur
	procedure Libere_Iterateur(It : in out Iterateur) is
	    Stock : Iterateur := It;
	begin
	   if (not A_Suivant(It)) then
	      Liberer(It.Courant);
	   else
	      while (Stock.Courant /= null) loop
		 Liberer(It.Courant);
		 Stock.Courant := Stock.Courant.Suiv;
		 It := Stock;
	      end loop;
	   end if;
	end Libere_Iterateur;

    -- Avance d'une case dans la liste
    procedure Suivant(It : in out Iterateur) is
    begin
       if not A_Suivant(It) then
	  raise FinDeListe;
       end if;
       
       It.Courant := It.Courant.Suiv;
    end Suivant;

    -- Retourne l'element courant
    function Element_Courant(It : Iterateur) return Element is
    begin
       if not A_Suivant(It) then
	  raise FinDeListe;
       end if;
       return It.Courant.all.Val;
    end Element_Courant;
    

    -- Verifie s'il reste un element a parcourir
    function A_Suivant(It : Iterateur) return Boolean is
    begin
       return (It.Courant.Suiv /= null);
    end A_Suivant;
    


   
end Liste_Generique;
