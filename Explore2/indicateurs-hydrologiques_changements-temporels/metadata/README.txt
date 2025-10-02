 ___             _                 ___ 
| __|__ __ _ __ | | ___  _ _  ___ |_  )
| _| \ \ /| '_ \| |/ _ \| '_|/ -_) / / 
|___|/_\_\| .__/|_|\___/|_|  \___|/___|
          |_|

{CITE}


INFORMATIONS GENERALES _______________________________________________
Le projet Explore2, porté par INRAE et l'Office International de l'eau
(OiEau), s'inscrit dans la suite de l'étude Explore 2070 (2010-2012)
qui avait conduit à l'élaboration des premiers scénarios prospectifs
de disponibilités de la ressource en eau à l'échelle de la France
sous changement climatique.

Le projet Explore2 a officiellement été lancé en juillet 2021.
Co-financé par les partenaires du projet, le Ministère de la
Transition Écologique et de la Cohésion des Territoires (MTECT) et 
l'Office Français de la Biodiversité (OFB), le projet Explore2 a eu
pour objectifs d'actualiser les connaissances sur l'impact du
changement climatique sur l'hydrologie à partir des dernières
publications du GIEC, et aussi d'accompagner les acteurs des
territoires dans la compréhension et l'utilisation de ces résultats
pour adapter leurs stratégies de gestion de la ressource en eau.

Le volet scientifique est coordonné par Éric Sauquet (INRAE).


RESSOURCES ___________________________________________________________
- Rapports techniques sur le dataverse d’Explore2 :
  https://entrepot.recherche.data.gouv.fr/dataverse/explore2
- Retrouvez les messages et enseignements du projet Explore2 :
  https://doi.org/10.57745/J3XIPW
- Retrouvez les messages et enseignements du projet Explore2
  selon les niveaux de réchauffement fixés par la TRACC :
  https://doi.org/10.57745/SRZ8I9
- Dossier INRAE / Appui aux Politiques Publiques :
  https://app.inrae.fr/expertise/dossier-le-projet-explore2-des-projections-hydrologiques-pour-adapter-la-gestion-de-la-ressource-en-eau/
- Accès aux données DRIAS climat pour les projections climatiques :
  https://www.drias-climat.fr/commande/
- Accès aux données DRIAS eau pour les projections hydrologiques :
  https://www.drias-eau.fr/commande/
- Accès aux données Recherche Data Gouv pour les projections
  hydrologiques :
  https://entrepot.recherche.data.gouv.fr/dataverse/explore2-projections_hydrologiques
- Accès aux données Recherche Data Gouv pour les indicateurs
  issus des projections hydrologiques :
  https://entrepot.recherche.data.gouv.fr/dataverse/explore2-indicateurs_hydrologiques
- Visualisation des données : https://meandre.explore2.inrae.fr/
- Visualisation des données par niveaux de réchauffement TRACC :
  https://meandre-tracc.explore2.inrae.fr/
- Formation : https://e-learning.oieau.fr/enrol/index.php?id=3799
- Séminaire de restitution du 28 juin 2024 :
  https://www.seminaire-explore2-lifeeauclimat.oieau.fr/
- Recommandations pour mener une étude rétrospective et prospective
  sur la ressource en eau : https://livreec.inrae.fr/


CONTACT ______________________________________________________________
Pour les projections hydrologiques journalières, privilégiez les
contacts propres à chaque modèle indiqué dans les fichiers NetCDF.

Pour les indicateurs hydrologiques :
- Héraut, Louis, ingénieur et data manager *1
  <louis.heraut@inrae.fr>
- Sauquet, Éric, directeur de recherche et project manager *1
  <eric.sauquet@inrae.fr>
- Vidal, Jean-Philippe, directeur de recherche *1
  <jean-philippe.vidal@inrae.fr>

1* INRAE, UR RiverLy, Villeurbanne, France


ATTENTIONS CONCERNANT LES PROJECTIONS ________________________________
L'approche multi-modèle doit être privilégiée :

 - Les événements temporels isolés ne sont pas des indicateurs
   robustes du changement hydro-climatique.

 - Isoler une trajectoire ne permet pas de conclure quant à la
   plausibilité de la réalisation de ce futur. Isoler un modèle
   hydrologique conduit à privilégier un modèle et à se concentrer
   sur un panel restreint des futurs possibles. 

 - La dispersion des résultats est inhérent aux dynamiques hydro-
   climatologiques et est un message en soi.

 - Rien n'indique que le futur qui va se réaliser est bien dans
   l'ensemble simulé.
   
 - Plus d'informations sur le diagnostic des modèles hydrologiques :
   https://doi.org/10.57745/S6PQXD et sur les bonnes pratiques
   d'exploitation des projections : https://livreec.inrae.fr/

En cas de doutes, retrouvez les messages et enseignements
du projet Explore2 : https://doi.org/10.57745/J3XIPW
Et par niveaux de réchauffement fixés par la TRACC :
https://doi.org/10.57745/SRZ8I9


DESCRIPTION DES DONNÉES ______________________________________________
Changements par horizons temporels d'indicateurs issus des débits
journaliers simulés par le modèle hydrologique {HM} pour
l'ensemble des projections climatiques Explore2 sous {RCP}.
Ces fichiers résultent de l'agrégation temporelle des simulations
hydrologiques sous runs historiques (avant 2005) et des projections
hydrologiques (post 2005), fichiers NetCDF disponibles au
téléchargement dans la collection Explore2 - Projections hydrologiques
https://entrepot.recherche.data.gouv.fr/dataverse/explore2-projections_hydrologiques.

Ce dépôt regroupe un tableau 2D par indicateur et chaîne de
simulation, c'est-à-dire, scénario d'émission RCP, couple GCM/RCM,
correction de biais BC et modèle hydrologique HM. Ces données sont
brutes et contiennent donc des chaînes de projections jugées
aberrantes / horsains qu'il est possible de filter grâce à des
métadonnées supplémentaires https://doi.org/10.57745/YZNENQ. Pour des
raisons techniques, ces indicateurs sont regroupés par dossiers
compressés selon les différentes parties du régime hydrologique.
Retrouvez davantage d'information sur la chaîne de modélisation
du climat dans le rapport https://doi.org/10.57745/PUR7ML.

La description des modèles hydrologiques utilisés est disponible dans
les annexes du rapport https://doi.org/10.57745/S6PQXD. Retrouvez le
diagnostic des modèles hydrologiques résumé à l'échelle des régions
hydrologiques dans les fiches téléchargeables ici :
https://doi.org/10.57745/DMFUXW.

Métadonnées supplémentaires :
- Récapitulatif de l'ensemble des indicateurs hydrologiques :
  href='https://doi.org/10.57745/JVNHQL
- Récapitulatif de l'ensemble des chaînes de simulation :
  https://doi.org/10.57745/R6HG5X
- Description de l'ensemble des points de simulation :
  https://doi.org/10.57745/UTKWR5
- Liste des simulations des chaînes de projections jugées aberrantes
  / horsains : https://doi.org/10.57745/YZNENQ
- Récapitulatif des années pivots utilisées pour la TRACC :
  https://doi.org/10.57745/DCOQM6

Décomposition des chaînes de caractère formant le nom des fichiers
parquet, séparées par des "_" :
{1}  Indicateur : Le nom de l’indicateur, du type de statistique
     observée
{2}  Échantillonnage : Échantillonnage temporel sur laquelle est
     calculé l’indicateur
-> {1}_{2} Variable : Variable résultante d'un indicateur
           temporellement contextualisé
{3}  HX : Horizon futur (H[123])
-> {1}_{2}_{3} Changement : Changement d'une variable pour un horizon
               temporel par rapport à une période de référence, défini
	       dans le récapitulatif des indicateurs
	       hydrologiques https://doi.org/10.57745/JVNHQL
{4}  EXP : Identifiant de l’expérience historique ou future via le
     scénario
{5}  GCM : Identifiant du GCM forçeur
{6}  RCM : Identifiant du RCM
{7}  BC : Identifiant de la méthode de correction de biais statistique
{8}  HM : Identifiant du modèle hydrologique
{9}  référence : Période de référence (ref-YYYYMMDD-YYYYMMDD)
{10} futur : Période futur (fut-YYYYMMDD-YYYYMMDD)

Les colonnes des fichier parquet sont :
- EXP : Voir ci-dessus
- GCM : Voir ci-dessus
- RCM : Voir ci-dessus
- BC : Voir ci-dessus
- HM : Voir ci-dessus
- code : Code à 10 caractère du point de simulation fourni dans la
  description des points de simualtion https://doi.org/10.57745/UTKWR5
- *variable* : Variable annuelle définie dans le récapitulatif des
  indicateurs hydrologiques https://doi.org/10.57745/JVNHQL
