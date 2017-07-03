
with Ada.Integer_Text_IO, Ada.Text_IO; 
use Ada.Integer_Text_IO, Ada.Text_IO;


package body Puissance4 is
   
 ---- Definition de l'adversaire d'un joueur ----
   
   function Adversaire(E : in Etat; J : in Joueur) return Joueur is
      Stock : Joueur;
   begin
      if (E.Joueur1.Symbole = J.Symbole) then 
	 Stock := E.Joueur2;
      else 
	 Stock := E.Joueur1;
      end if;
      
	 return Stock;
	   
      end Adversaire;

      
---- Initialisation de l'etat ; les joueurs ont des symboles predefinis ; le plateau est initialise avec des espaces ----
   function New_Etat return Etat is
      E : Etat;
   begin 
      for I in 1..Hauteur loop
	 for J in 1..Largeur loop
	    E.Plateau(I,J) := ' ';
	 end loop;
      end loop;
      E.Joueur1.Symbole := 'X';
      E.Joueur2.Symbole := 'O';
      return E;
   end New_Etat;
   
   ---- Affichage du plateau de jeu ----
   
   procedure Affiche_Jeu(E : in Etat) is
   begin
      
      for I in 1..Largeur loop
	 Put(Integer'Image(I));
      end loop;
      Put_Line("");
	 for I in 1..Hauteur loop
	    for J in 1..Largeur loop
	       Put("|"& E.Plateau(I,J));
	    end loop;
	    Put_Line("|");
	    
	 end loop;
	 Put_Line("");
      
   end Affiche_Jeu;
   
   
   ---- On determine l'etat suivant, en cherchant la prochaine case vide d'une colonne si elle existe; si elle n'existe pas, on peut eventuellement lever une exception ----
   function Etat_Suivant(E : in out Etat; C : in Coup) return Etat is
      I : Integer;
   begin
      I := Hauteur;
      while ((E.Plateau(I,C.Numero_Colonne) = C.Player.Symbole) or (E.Plateau(I,C.Numero_Colonne) = Adversaire(E,C.Player).Symbole))loop
	 I := I - 1;
	 exit when (I <= 0);
      end loop;
      if (I > 0) then
	 E.Plateau(I,C.Numero_Colonne) := C.Player.Symbole;
      end if;
      
      return E;
   end Etat_Suivant;
   
   ---- On prend en compte le coup du premier joueur, a partir du terminal ----
   
   function Coup_Joueur1(E : in Etat) return Coup is
      C : Coup;
      Courant : Integer;
   begin
       Put(" Numero de colonne : ");
      Get(Courant);
      C.Numero_Colonne := Courant;
      C.Player.Symbole := E.Joueur1.Symbole;
      return C;
   end Coup_Joueur1;
   
   ---- De meme pour le deuxieme joueur ----
   
   function Coup_Joueur2(E : in Etat) return Coup is
      C : Coup;
      Courant : Integer;
   begin
       Put(" Numero de colonne : ");
      Get(Courant);
      C.Numero_Colonne := Courant;
      C.Player.Symbole := E.Joueur2.Symbole;
      return C;
   end Coup_Joueur2;
   
   ---- Affichage du coup, en tout cas du numero de colonne ----
   
 procedure Affiche_Coup(C : in Coup) is
   begin 
       Put_Line("joue en colonne : " & Integer'Image(C.Numero_Colonne));
      Put_Line(" ");
   end Affiche_Coup;
   
   ---- Y a t il un alignement sur la ligne donnee ? ----
   
   function Alignement_Ligne(E : in Etat; C : Character; I : Integer) return Boolean is
      Flag : Boolean;
   begin
      for K in 1 .. (Largeur - Alignement + 1) loop
	 Flag := True;
	 for L in 1 .. Alignement loop
	    Flag := (Flag and (E.Plateau(I,K+L-1) = C));
	 end loop;
	 exit when Flag;
      end loop;
      return Flag;
   end Alignement_Ligne;
   
   
   ---- Y a t il un alignement sur la colonne donnee ? ----
   
   function Alignement_Colonne(E : in Etat; C : Character; J : Integer) return Boolean is
      Flag : Boolean;
   begin
      for K in 1 .. (Hauteur - Alignement + 1) loop
	 Flag := True;
	 for L in 1 .. Alignement loop
	    Flag := (Flag and (E.Plateau(K+L-1,J) = C));
	 end loop;
	 exit when Flag;
      end loop;
      return Flag;
   end Alignement_Colonne;
   
  
 ---- Y a t il un alignement sur une quelconque diagonale ? ----
   
   function Alignement_Diagonales(E : in Etat; C : Character) return Boolean is
      Flag : Boolean;
   begin
      
      ---- Premier type de diagonales ----
      
      for I in 1 .. (Hauteur - Alignement + 1) loop
	 for J in 1 .. (Largeur - Alignement + 1) loop
	    Flag := True;
	    for L in 1 .. Alignement loop
	       Flag := (Flag and (E.Plateau(I + L-1, J + L - 1) = C));
	    end loop;
	    exit when Flag;
	 end loop;
	 exit when Flag;
      end loop;
      
      ---- Deuxieme type de diagonales, si on n'a pas deja trouve d'alignement ---- 
      
      if not Flag then 
	 for I in 1 .. (Hauteur + 1 - Alignement) loop
	    if (Largeur < Alignement) then
	       
	 for J in Largeur .. Alignement loop
	    Flag := True;
	    for L in 1 .. Alignement loop
	       Flag := (Flag and (E.Plateau(I + L-1, J - L + 1) = C));
	    end loop;
	    exit when Flag;
	 end loop;
	    end if;
	    if (Largeur >= Alignement) then
	        for J in Alignement .. Largeur loop
	    Flag := True;
	    for L in 1 .. Alignement loop
	       Flag := (Flag and (E.Plateau(I + L-1, J - L + 1) = C));
	    end loop;
	    exit when Flag;
		end loop;
	    end if;
	    
	 exit when Flag;
	  end loop;
      end if;
      
      return Flag;
   end Alignement_Diagonales;
   
   
   ---- Un getter parce que c'est plus pratique ----
   
   function GetJoueur1(E : in Etat) return Joueur is 
   begin
      return E.Joueur1;
   end GetJoueur1;
   
   
   ---- L'etat est il gagnant pour le joueur ? plus qu'a utiliser les trois fonctions d'alignement avec le symbole du joueur ----
   
   function Est_Gagnant(E : in Etat; J : in Joueur) return Boolean is
      Flag : Boolean := False;
      C : Character := J.Symbole;
   begin 
      for I in 1 .. Hauteur loop
	 Flag := (Flag or Alignement_Ligne(E,C,I));
	 exit when Flag;
      end loop;
      
      if not Flag then
	 for K in 1 .. Largeur loop 
	    Flag := (Flag or Alignement_Colonne(E,C,K));
	    exit when Flag;
	 end loop;
      end if;
	 
      if not Flag then 
	 Flag := (Flag or Alignement_Diagonales(E,C));
      end if;
      
      
      return Flag;
   end Est_Gagnant;
   
   ---- On compte les cases pleines et on regarde si l'etat n'est pas gagnant pour un des deux joueurs ; pourrait etre fait autrement, puisque generalement lorsqu'on teste si l'etat est nul, on teste avant si l'etat est gagnant pour un des deux joueurs, donc le test de l'etat gagnant est redondant, sans grande incidence ----
   
   function Est_Nul(E : in Etat) return Boolean is
      Compteur : Integer := 0;
   begin 
      for I in 1 .. Hauteur loop
	 for J in 1 .. Largeur loop
	    if ((E.Plateau(I,J) = E.Joueur1.Symbole) or (E.Plateau(I,J) = E.Joueur1.Symbole)) then
	       Compteur := Compteur + 1;
	    end if;
	 end loop;
      end loop;
      return ((Compteur = Hauteur*Largeur) and not (Est_Gagnant(E,E.Joueur1) or Est_Gagnant(E,E.Joueur2)));
   end Est_Nul;
   
   
   ---- Evaluation statique sur une colonne : on compte les alignements, et les alignements qui comportent des cases vides directement connectees ----
   
    function Eval_Colonne(E : in Etat; C : Character; J : Integer; A : Integer) return Integer is
       Flag : Boolean;
       Compteur : Integer := 0;
   begin
      for K in 1 .. (Hauteur - A + 1) loop
	 Flag := True;
	 for L in 1 .. A loop
	    Flag := (Flag and (E.Plateau(K+L-1,J) = C));
	 end loop;
	 if Flag then
	    if (K > 1) and then (E.Plateau(K-1,J) = ' ') then
	       Compteur := Compteur + 100;
	    elsif (K > 2) and then (E.Plateau(K-2,J) = ' ') and then (E.Plateau(K-1,J) = ' ') then
	      Compteur := Compteur + 200;
	    else 
	       Compteur := Compteur + 50;
	    end if;
	    
	 end if;
	 
      end loop;
      return Compteur;
   end Eval_Colonne;
   
   ---- De meme sur une ligne ----
   
  function Eval_Ligne(E : in Etat; C : Character; I : Integer; A : Integer) return Integer is
     Flag : Boolean;
     Compteur : Integer := 0;
   begin
      for K in 1 .. (Largeur - A + 1) loop
	 Flag := True;
	 for L in 1 .. A loop
	    Flag := (Flag and (E.Plateau(I,K+L-1) = C));
	 end loop;
         if Flag then
	    if (K > 1) and then (E.Plateau(I,K-1) = ' ') then
	       Compteur := Compteur + 100;
	    elsif ((K+A)<Largeur) and then (E.Plateau(I,K+A) = ' ') then
	       Compteur := Compteur + 100;
	    elsif (K > 2) and then (E.Plateau(I,K-2) = ' ') and then (E.Plateau(I,K-1) = ' ') then
	       Compteur := Compteur + 200;
	    elsif (K+A+1 < Largeur) and then (E.Plateau(I,K+A) = ' ') and then (E.Plateau(I,K+A+1) = ' ') then
	      Compteur := Compteur + 200;
	    else 
	       Compteur := Compteur + 50;
	    end if;
	 end if;
	 
      end loop;
      return Compteur;
   end Eval_Ligne;
   
   
   ---- On compte les alignements sur les diagonales ----
   
   function Eval_Diagonales(E : in Etat; C : Character; A : Integer) return Integer is
      Flag : Boolean;
      Compteur : Integer := 0;
   begin
      
      for I in 1 .. (Hauteur - A + 1) loop
	 for J in 1 .. (Largeur - A + 1) loop
	    Flag := True;
	    for L in 1 .. A loop
	       Flag := (Flag and (E.Plateau(I + L-1, J + L - 1) = C));
	    end loop;
	    if Flag then
	       Compteur := Compteur + 30;
	    end if;	    
	 end loop;
      end loop;
     
      
      for I in 1 .. (Hauteur + 1 - A) loop
	 if (A < Largeur) then
	 for J in A .. Largeur loop
	    Flag := True;
	    for L in 1 .. A loop
	       Flag := (Flag and (E.Plateau(I + L-1, J - L + 1) = C));
	    end loop;
	    if Flag then
	       Compteur := Compteur + 30;
	    end if;
     	 end loop;
	 end if;
         if (A >= Largeur) then
	 for J in Largeur .. A loop
	    Flag := True;
	    for L in 1 .. A loop
	       Flag := (Flag and (E.Plateau(I + L-1, J - L + 1) = C));
	    end loop;
	    if Flag then
	       Compteur := Compteur + 30;
	    end if;
     	 end loop;
	 end if; 
	 
     end loop;
      
      return Compteur;
   end Eval_Diagonales;
   
   ---- La fonction d'eval statique ; evalue la situation pour chaque joueur selon les fonctions precedemment definies ----
   
   function Eval(E : Etat; J : Joueur) return Integer is
      Compteur_1 : Integer := 0;
      Compteur_2 : Integer := 0;
      Adv : Joueur ;
   begin
      
      Adv := Adversaire(E, J);
      for K in 2 .. (Alignement -1) loop
	 Compteur_1 := Compteur_1 + Eval_Diagonales(E,J.Symbole,K);
	 Compteur_2 := Compteur_2 + Eval_Diagonales(E,Adv.Symbole,K);
      end loop;
      
      
      for I in 1 .. Hauteur loop
	 for K in 2 .. (Alignement -1) loop
	 Compteur_1 := Compteur_1 + Eval_Ligne(E,J.Symbole,I,K);
	 Compteur_2 := Compteur_2 + Eval_Ligne(E,Adv.Symbole,I,K);
	 end loop;
      end loop;
      
      for L in 1 .. Largeur loop
	 for K in 2 .. (Alignement -1) loop
	 Compteur_1 := Compteur_1 + Eval_Colonne(E,J.Symbole,L,K);
	 Compteur_2 := Compteur_2 + Eval_Colonne(E,Adv.Symbole,L,K);
	 end loop;
      end loop; 
      
      return (Compteur_1 - Compteur_2);
      
   end Eval;
   
   ---- Retourne la liste des coups possibles pour le joueur J dans l'etat donne; un coup est possible dans une colonne donnee si la colonne n'est pas vide ----
   
   function Coups_Possibles(E : Etat; J : Joueur) return Liste is
      L : Liste := Creer_Liste;
      C : Coup;
   begin
      C.Player := J;
      C.Numero_Colonne := 0;	
      Insere_Tete(C,L);
      for K in 1 .. Largeur loop
	 if (E.Plateau(1,K) = ' ') then
	    C.Player := J;
	    C.Numero_Colonne := K;
	    Insere_Tete(C,L);
	 end if;
      end loop;
      
      return L;
   end Coups_Possibles;
   
      
      
   
   
end Puissance4;
