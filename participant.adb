----
---- Ce package n'est pas utilise, nous avons implemente 
---- "Adversaire" dans puissance4.adb

package body Participant is
   
   function Adversaire(J : Joueur) return Joueur is
      begin
      if (J = Joueur1) then 
	 return Joueur2;
      else 
	 return Joueur1;
      end if;
      end Adversaire;
      
end Participant;
