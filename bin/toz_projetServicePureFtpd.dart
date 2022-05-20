import 'ihm.dart';
import 'methodeCommande.dart';

class DevOps {
  static Future<void> creationUtilisateurFtpd(
      bool exit, String uid, String gid) async {
    print("Creation d'un utilisateur");
    String cmdIci = 'pwd';
    String ici = await CMD.recupererDonneeBash(cmdIci);
    String cmd1 = 'echo $ici';
    await CMD.execBash(cmd1);
    String cmdMdp = "date|md5sum|cut -d ' ' -f 1";
    String mdp = await CMD.recupererDonneeBash(cmdMdp);
    String cmd = 'echo $mdp';
    await CMD.execBash(cmd);

    if (!exit) {
      // Installation des spaquets
      print("Vérification des paquets...");
      await CMD.verifPaquet('whois');
      await CMD.verifPaquet('pure-ftpd');
    }

    if (!exit) {
      // Non-existence du compte GID
      print("Vérification de la non-existence du compte GID...");
      String cmdRep = 'cat /etc/group|cut -d \':\' -f 3|grep "$gid"';
      String rep = await CMD.recupererDonneeBash(cmdRep);
      rep = CMD.repIntoString(rep);
      if (rep == gid) {
        print("Le groupe $gid est déjà utilisé");
        exit = true;
      }
    }

    if (!exit) {
      // Non-existence du compte UID
      print("Vérisfication de la non-existence du compte UID...");
      String cmdRep = 'cat /etc/passwd|cut -d \':\' -f 3|grep "$uid"';
      String rep = await CMD.recupererDonneeBash(cmdRep);
      rep = CMD.repIntoString(rep);
      if (rep == uid) {
        print("L'utilisateur $uid est déjà utilisé");
        exit = true;
      }
    }

    if (!exit) {
      // Création du groupe
      print("Création du groupe...");
      String cmd = 'groupadd -g "$gid" ftpuser 2> /dev/null';
      await CMD.execBash(cmd);

      // Création du dossier spécial
      print("Création du dossier spécial...");
      cmd = 'mkdir /home/FTPUSER 2> /dev/null';
      await CMD.execBash(cmd);

      // Création de l'utilisateur
      print("Création de l'utilisateur...");
      cmd =
          'useradd -d /home/FTPUSER -u "$uid" -g "$gid" -p \$(mkpasswd "$mdp") -s /usr/sbin/nologin ftpuser 2> /dev/null';
      await CMD.execBash(cmd);

      // Configuration de pure-ftpd
      print("Configuration de pure-ftpd...");
      cmd = 'echo "yes" > /etc/pure-ftpd/conf/CreateHomeDir';
      await CMD.execBash(cmd);

      cmd = 'cd /etc/pure-ftpd/auth';
      await CMD.execBash(cmd);

      cmd = 'ln -s ../conf/PureDB 60puredb 2> /dev/null';
      await CMD.execBash(cmd);

      // Droits
      print("Configuration des droits...");
      cmd = 'chown -R root:root /home/FTPUSER';
      await CMD.execBash(cmd);

      cmd = 'chown -R root:root /etc/pure-ftpd/conf';
      await CMD.execBash(cmd);

      // Fin
      print("");
      print("");
      print(
          "Ne pas oublier de créer un utilisateur virtuel avant de redémarrer ...");
      print("");
      print("");

      cmd = 'cd $ici';
      await CMD.execBash(cmd);
    }
  }

  static Future<void> creationUtilisateurVirtuel(String uid, String gid) async {
    print("Creation d'un utilisateur virtuel");
    String user = IHM.saisirString();
    String cmd =
        'pure-pw useradd $user -u $uid -g $gid -d /home/FTPUSER/$user -m';
    await CMD.execBashInteract(cmd);
  }

  static Future<void> telechargementWebapp() async {
    IHM.affichageWebapps();
    String user = "eleve";
    String password = "educ2122";
    String appli = IHM.saisirString();
    String cmd = "";

    // Installation des paquets
    CMD.installPaquet("wget");
    CMD.installPaquet("zip");

    // Vérification que le nom d'application corresponde bien à une application
    if (appli == "dokuwiki") {
      cmd =
          'wget https://www.pedagogeek.fr/cours/srvweb/Ressources/appliweb/dokuwiki.tgz --user=$user --password=$password';
      await CMD.execBash(cmd);
      cmd = 'tar -xzvf dokuwiki.tgz';
      await CMD.execBash(cmd);
    } else if (appli == "mediawiki") {
      cmd =
          'wget https://www.pedagogeek.fr/cours/srvweb/Ressources/appliweb/mediawiki-1.37.1.tar.gz --user=$user --password=$password';
      await CMD.execBash(cmd);
      cmd = 'tar -xzvf mediawiki-1.37.1.tar.gz';
      await CMD.execBash(cmd);
    } else if (appli == "glpi") {
      cmd =
          'wget https://www.pedagogeek.fr/cours/srvweb/Ressources/appliweb/glpi-9.5.6.tgz --user=$user --password=$password';
      await CMD.execBash(cmd);
      cmd = 'tar -xzvf glpi-9.5.6.tgz';
      await CMD.execBash(cmd);
    } else if (appli == "joomla") {
      cmd =
          'wget https://www.pedagogeek.fr/cours/srvweb/Ressources/appliweb/Joomla_410-Stable-fr.zip --user=$user --password=$password';
      await CMD.execBash(cmd);
      cmd = 'unzip Joomla_410-Stable-fr.zip';
      await CMD.execBash(cmd);
    } else if (appli == "wordpress") {
      cmd =
          'wget https://www.pedagogeek.fr/cours/srvweb/Ressources/appliweb/wordpress-5.8.3-fr_FR.tar.gz --user=$user --password=$password';
      await CMD.execBash(cmd);
      cmd = 'tar -xzvf wordpress-5.8.3-fr_FR.tar.gz';
      await CMD.execBash(cmd);
    } else if (appli == "phpBB") {
      cmd =
          'wget https://www.pedagogeek.fr/cours/srvweb/Ressources/appliweb/phpBB-3.3.5.zip --user=$user --password=$password';
      await CMD.execBash(cmd);
      cmd = '	unzip phpBB-3.3.5.zip';
      await CMD.execBash(cmd);
    } else if (appli == "GNU-social") {
      cmd =
          'wget https://www.pedagogeek.fr/cours/srvweb/Ressources/appliweb/gnu-social-master.tar.gz --user=$user --password=$password';
      await CMD.execBash(cmd);
      cmd = 'tar -xzvf gnu-social-master.tar.gz';
      await CMD.execBash(cmd);
    } else {
      print("Vous n'avez pas donner le bon nom d'application");
    }
  }
}

// stdout = canal 1 bash
// stderr = canal 2 bash
