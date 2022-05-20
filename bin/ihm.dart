import 'dart:io';

class IHM {
  static int saisirInt() {
    bool valide = false;
    int i = 0;
    while (!valide) {
      print("Veuillez indiquer un nombre entier :");
      try {
        i = int.parse(stdin.readLineSync().toString());
        valide = true;
      } catch (e) {
        print("Erreur lors de la saisie");
      }
    }
    return i;
  }

  static String saisirString() {
    bool valide = false;
    String c = "";
    while (!valide) {
      print("Veuillez saisir une chaîne de caractère :");
      try {
        c = stdin.readLineSync().toString();
        valide = true;
      } catch (e) {
        print("Erreur lors de la saisie");
      }
    }
    return c;
  }

  static String getPassword() {
    bool valide = false;
    String c = "";
    while (!valide) {
      print("Veuillez saisir votre mot de passe :");
      try {
        stdin.echoMode = false;
        c = stdin.readLineSync().toString();
        stdin.echoMode = true;
        valide = true;
      } catch (e) {
        print("Erreur lors de la saisie");
      }
    }
    return c;
  }

// Saisie d'une action en fonction du nombre d'action autre que quitter
  static int saisirAction(int max) {
    bool valide = false;
    int action = -1;
    while (!valide) {
      try {
        action = saisirInt();
        if (action >= 0 && action <= max) {
          valide = true;
        } else {
          print("Vous n'avez pas saisi une action valide.");
        }
      } catch (e) {
        print("Erreur lors de la saisie");
      }
    }
    return action;
  }

  static void affichageEcran() {
    print("");
    print("+-------------------------------------------------------+");
    print("|                                                       |");
    print("|   Menu                                                |");
    print("|   Quelle programme voulez-vous executer ?             |");
    print("|   0 = Fin                                             |");
    //print("|   1 = Test ping                                       |");
    //print("|   2 = Installation d'un serveur apache                |");
    //print("|   3 = Télécharger une webapp                          |");
    //print("|   4 = Installation d'une webapp sur le serveur        |");
    print("|   1 = Créer un utilisateur ftpd                       |");
    print("|   2 = Créer un utilisateur virtuel ftpd               |");
    //print("|   3 = Configurer un utilisateur virtuel ftpd          |");
    //print("|   X = Installation et configuration d'un fail2ban     |");
    print("|                                                       |");
    print("+-------------------------------------------------------+");
  }

  static void affichageWebapps() {
    print("");
    print("+-------------------------------------------------------+");
    print("|                                                       |");
    print("|   Menu - Webapps                                      |");
    print("|   Quelle application voulez-vous récupérer ?          |");
    print("|   Veuillez taper le nom d'une des applications        |");
    print("|   suivantes :                                         |");
    print("|   dokuwiki, mediawiki, wordpress, glpi, phpBB         |");
    print("|   joolma, GNU-social                                  |");
    print("|   3 = Télécharger une webapp                          |");
    print("|                                                       |");
    print("+-------------------------------------------------------+");
  }
}
