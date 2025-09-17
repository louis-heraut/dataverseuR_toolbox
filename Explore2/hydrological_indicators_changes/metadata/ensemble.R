
META$title = "Changements par horizon temporel pour l'ensemble des projections hydrologiques Explore2 du débit (référence 1976-2005)"
META$alternativeTitle = "Collection Explore2 - Indicateurs hydrologiques / Changements par horizon temporel"

META$alternativeURL = "https://entrepot.recherche.data.gouv.fr/dataverse/explore2-indicateurs_hydrologiques-changements_temporels"

META$datasetContactName = "Héraut, Louis"
META$datasetContactAffiliation = "INRAE, UR RiverLy, Villeurbanne, France"
META$datasetContactEmail = "louis.heraut@inrae.fr"


META$authorName1 = "Héraut, Louis"
META$authorAffiliation1 = "INRAE, UR RiverLy, Villeurbanne, France"
META$authorIdentifierScheme1 = "ORCID"
META$authorIdentifier1 = "0009-0006-4372-0923"


META$producerName = "Explore2"
META$producerURL = "https://professionnels.ofb.fr/fr/node/1244"
META$producerLogoURL = "https://entrepot.recherche.data.gouv.fr/logos/202158/LogoExplore2.png"

META$distributorName = "Entrepôt-Catalogue Recherche Data Gouv"
META$distributorURL = "https://entrepot.recherche.data.gouv.fr"
META$distributorLogoURL = "https://s3.fr-par.scw.cloud/rdg-portal/logos-macarons/Macarons%20Recherche%20Data%20Gouv_Entrep%C3%B4t.png"


META$dsDescriptionValue = "Ensemble de 540 chaînes de simulations de débits journaliers issus de 9 modèles hydrologiques pour l'ensemble des projections climatiques Explore2. Ces fichiers résultent de la concaténation des simulations hydrologiques sous runs historiques (avant 2005) et des projections hydrologiques (post 2005), fichiers NetCDF disponibles au téléchargement sur le portail <a href='https://www.drias-eau.fr/commande' target='blank_'>https://www.drias-eau.fr/commande</a>.<br><br>

Ce dépôt renvoit vers l'ensemble des sous-jeux de données séparés par modèles hydrologiques et scénario RCP. Chacun de ces sous-jeux de données regroupe un fichier NetCDF par couple GCM/RCM et correction de biais. Retrouvez davantage d'information sur la chaîne de modélisation du climat dans les métadonnées des fichiers NetCDF et le rapport <a href='https://doi.org/10.57745/PUR7ML' target='blank_'>https://doi.org/10.57745/PUR7ML </a>.<br><br>

La description des modèles hydrologiques utilisés est disponible dans les annexes du rapport <a href='https://doi.org/10.57745/S6PQXD' target='blank_'>https://doi.org/10.57745/S6PQXD</a>. Retrouvez le diagnostic des modèles hydrologiques résumé à l'échelle des régions hydrologiques dans les fiches téléchargeables ici : <a href='https://doi.org/10.57745/DMFUXW' target='blank_'>https://doi.org/10.57745/DMFUXW</a>.<br><br>

<b>Métadonnées supplémentaires</b> :<ul>
<li>Description de l'ensemble des chaînes de modélisations : <a href='https://doi.org/10.57745/R6HG5X' target='blank_'>https://doi.org/10.57745/R6HG5X</a></li>
<li>Description de l'ensemble des points de simulation : <a href='https://doi.org/10.57745/UTKWR5' target='blank_'>https://doi.org/10.57745/UTKWR5</a></li>
<li>Liste des simulations des chaînes de projections jugées aberrantes / horsains : <a href='https://doi.org/10.57745/YZNENQ' target='blank_'>https://doi.org/10.57745/YZNENQ</a></li></ul>

<b>Décomposition des chaînes de caractère formant le nom des fichiers NetCDF, séparées par des \"_\"</b> :<br>
{1}:  Variable : Nom de la variable (avec Adjust si les données sont corrigées)<br>
{2}:  Domain : Couverture spatiale des données<br>
{3}:  GCM-Inst-Model : Identifiant du GCM forçeur = Institut-Modèle<br>
{4}:  Experiment : Identifiant de l’expérience historique ou future via le scénario<br>
{5}:  Member : Numéro du membre de l'ensemble<br>
{6}:  RCM-Inst-Model : Identifiant du RCM = Institut-Modèle<br>
{7}:  Version : Identifiant de l’expérience historique ou future via le scénario<br>
{8}:  Bc-Inst-Method-Obs-Period : Identifiant de la méthode de correction de biais statistique =
Institut-Méthode-Réanalyse-Période<br>
{9}:  HYDRO-Inst-Model : Identifiant du HYDRO = Institut-Modèle<br>
{10}: TimeFrequency : Pas de temps du jeu de données<br>
{11}: Startyear-Endyear : Couverture temporelle des données sous forme YYYYMMDD-YYYYMMDD"

META$dsDescriptionLanguage = "French"
META$language = "French"
META$subject = "Earth and Environmental Sciences"


META$keywordValue1 = "hydrology"
META$keywordTermURL1 = "http://opendata.inrae.fr/thesaurusINRAE/c_11593"
META$keywordVocabulary1 = "INRAETHES"
META$keywordVocabularyURI1 = "http://opendata.inrae.fr/thesaurusINRAE/thesaurusINRAE"

META$keywordValue2 = "hydrological model"
META$keywordTermURL2 = "http://opendata.inrae.fr/thesaurusINRAE/c_1352"
META$keywordVocabulary2 = "INRAETHES"
META$keywordVocabularyURI2 = "http://opendata.inrae.fr/thesaurusINRAE/thesaurusINRAE"

META$keywordValue3 = "hydrological projection"

META$keywordValue4 = "climate change impacts"
META$keywordTermURL4 = "http://aims.fao.org/aos/agrovoc/c_13fb5a08"
META$keywordVocabulary4 = "AGROVOC"
META$keywordVocabularyURI4 = "http://aims.fao.org/aos/agrovoc/"

META$topicClassValue = "Hydrologie"
META$topicClassVocab = "INRAE Thésaurus"
META$topicClassVocabURI = "http://opendata.inrae.fr/thesaurusINRAE/c_1108"

META$kindOfData = "Dataset"
META$kindOfDataOther = "Projections hydrologiques (débit) - Ensemble"
META$dataOrigin = "simulation data"


META$softwareName1 = "CTRIP"
META$softwareVersion1 = "x"

META$softwareName2 = "EROS"
META$softwareVersion2 = "x"

META$softwareName3 = "GRSD"
META$softwareVersion3 = "x"

META$softwareName4 = "J2000"
META$softwareVersion4 = "x"

META$softwareName5 = "MORDOR-SD"
META$softwareVersion5 = "x"

META$softwareName6 = "MORDOR-TS"
META$softwareVersion6 = "x"

META$softwareName7 = "ORCHIDEE"
META$softwareVersion7 = "x"

META$softwareName8 = "SIM2"
META$softwareVersion8 = "x"

META$softwareName9 = "SMASH"
META$softwareVersion9 = "x"

META$seriesName1 = "RCP 2.6"
META$seriesName2 = "RCP 4.5"
META$seriesName3 = "RCP 8.5"


META$projectAcronym = "Explore2"
META$projectTitle = "Explore2 : Des futurs de l'eau"
META$projectURL = "https://app.inrae.fr/expertise/dossier-le-projet-explore2-des-projections-hydrologiques-pour-adapter-la-gestion-de-la-ressource-en-eau/"


META$timePeriodCoveredStart = "1976-01-01"
META$timePeriodCoveredEnd = "2100-12-31"

META$country = "France"

META$depositor = "HERAUT, LOUIS"
