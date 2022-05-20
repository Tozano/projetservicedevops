import 'dart:io';

import 'ihm.dart';

class CMD {
  static Future<String> recupererDonneeBash(String cmd) async {
    String valeur = "Erreur, la commande n'a pas fonctionnée";
    await Process.run('bash', ['-c', cmd]).then((result) {
      valeur = result.stdout;
    });
    return valeur;
  }

  static Future<void> execEtAfficherBash(String cmd) async {
    await Process.run('bash', ['-c', cmd]).then((result) {
      if (result.stderr == '') {
        print(result.stdout);
      }
      if (result.stderr != '') {
        print(result.stderr);
      }
    });
  }

  static Future<void> execBash(String cmd) async {
    await Process.run('bash', ['-c', cmd]).then((result) {
      if (result.stderr != '') {
        print(result.stderr);
      }
    });
  }

  static Future<void> execBashInteract(String cmd) async {
    Process p = await Process.start("bash", ['-c', cmd]);
    stdout.addStream(p.stdout);
    stderr.addStream(p.stderr);
    p.stdin.addStream(stdin);
  }

  static Future<void> execBashInteractPassword(String cmd) async {
    Process p = await Process.start("bash", ['-c', cmd]);
    stdout.addStream(p.stdout);
    stderr.addStream(p.stderr);
    String mdp = IHM.getPassword();
    p.stdin.writeln(mdp);
    p.stdin.writeln(mdp);
  }

  static Future<bool> verifAdmin() async {
    bool exit = false;
    String cmdRep = 'whoami';
    String rep = await recupererDonneeBash(cmdRep);
    rep = repIntoString(rep);
    if (rep != 'root') {
      print("Il faut être 'root'");
      exit = true;
    }
    return exit;
  }

  static Future<void> verifPaquet(String lePaquet) async {
    String cmdRep = 'dpkg --list|grep "$lePaquet"';
    String rep = await recupererDonneeBash(cmdRep);
    if (rep != " $lePaquet ") {
      await installPaquet(lePaquet);
    }
  }

  static Future<void> installPaquet(String lePaquet) async {
    String cmdUpdate = 'apt-get -y update';
    await execBash(cmdUpdate);
    String cmdInstall = 'apt-get -y install $lePaquet';
    await execBash(cmdInstall);
  }

  static String repIntoString(String rep) {
    int l = rep.length;
    String modif = "";
    for (var i = 0; i < l - 1; i++) {
      modif = modif + rep[i];
    }
    return modif;
  }
}
