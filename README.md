Ce projet en dart permet de générer un exécutable en Bash.
Il est séparé en 4 fichiers :
- Le main
- L'IHM, qui gère les différentes vues et affichages
- Une classe CMD contenant les méthodes qui permettent à une commande d'être transformée en Bash et d'être comprise par l'ordinateur
- Une classe DevOps contenant les méthodes de chaque service

Seul 2 services sont utilisables actuellement :
- L'installation de pure-ftpd et la création du ftpuser
- La création de nouveaux utilisateurs virtuels associées au ftpuser
La création d'un service de téléchargement et de décompression de certaines webapps est actuellement en cours.

Plusieurs verifications sont installées :
- La nécessité que l'utilisateur soit en Root (pour permettre l'utilisation de certaines commandes)
- La vérification de la présence de certains paquets, et s'ils ne sont pas présents, ils sont téléchargés
- La vérification, dans le cas de la création du ftpuser, de la disponibilité du nombre du GID et de l'UID. Si l'un d'eux est déjà utilisé, alors le programme s'arrête.