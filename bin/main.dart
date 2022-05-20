import 'ihm.dart';
import 'methodeCommande.dart';
import 'toz_projetServicePureFtpd.dart';

main(List<String> args) async {
  // Commande compilation : "dart compile exe bin/main.dart -o /tmp/pureFtpd"

  String gid = "1001";
  String uid = "1001";
  bool exit = false;

  // Il faut être admininistrateur
  exit = await CMD.verifAdmin();

  if (!exit) {
    IHM.affichageEcran();

    //saisir une option
    int choix = -1;

    while (choix != 0) {
      choix = IHM.saisirAction(2);
      if (choix == 1) {
        await DevOps.creationUtilisateurFtpd(exit, uid, gid);
      } else if (choix == 2) {
        await DevOps.creationUtilisateurVirtuel(uid, gid);
      } /*else if (laTable == 3) {
        await telechargementWebapp();
      }*/
    }
  }
}
