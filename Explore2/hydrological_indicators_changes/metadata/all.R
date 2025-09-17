
META$title = "Changements par horizon temporel des projections hydrologiques Explore2 du débit pour le modèle {HM} sous {RCP} (référence 1976-2005)"

META$alternativeURL = "https://www.drias-eau.fr/commande"

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


META$dsDescriptionValue = "Débit journalier simulé par le modèle hydrologique {HM} pour l'ensemble des projections climatiques Explore2 sous {RCP}. Ces fichiers résultent de la concaténation des simulations hydrologiques sous runs historiques (avant 2005) et des projections hydrologiques (post 2005), fichiers NetCDF disponibles au téléchargement sur le portail <a href='https://www.drias-eau.fr/commande' target='blank_'>https://www.drias-eau.fr/commande</a>.<br><br>

Ce dépôt regroupe un fichier NetCDF par couple GCM/RCM et correction de biais. Retrouvez davantage d'information sur la chaîne de modélisation du climat dans les métadonnées des fichiers NetCDF et le rapport <a href='https://doi.org/10.57745/PUR7ML' target='blank_'>https://doi.org/10.57745/PUR7ML </a>.<br><br>

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

META$keywordValue2 = "indicator"
META$keywordTermURL2 = "http://opendata.inrae.fr/thesaurusINRAE/c_16171"
META$keywordVocabulary2 = "INRAETHES"
META$keywordVocabularyURI2 = "http://opendata.inrae.fr/thesaurusINRAE/thesaurusINRAE"

META$keywordValue3 = "temporal aggregation"

META$keywordValue4 = "hydrological model"
META$keywordTermURL4 = "http://opendata.inrae.fr/thesaurusINRAE/c_1352"
META$keywordVocabulary4 = "INRAETHES"
META$keywordVocabularyURI4 = "http://opendata.inrae.fr/thesaurusINRAE/thesaurusINRAE"

META$keywordValue5 = "hydrological projection"

META$keywordValue6 = "climate change impacts"
META$keywordTermURL6 = "http://aims.fao.org/aos/agrovoc/c_13fb5a08"
META$keywordVocabulary6 = "AGROVOC"
META$keywordVocabularyURI6 = "http://aims.fao.org/aos/agrovoc/"


META$topicClassValue = "Hydrologie"
META$topicClassVocab = "INRAE Thésaurus"
META$topicClassVocabURI = "http://opendata.inrae.fr/thesaurusINRAE/c_1108"


META$kindOfData = "Dataset"
META$kindOfDataOther = "Changements par horizon temporel (débit)"
META$dataOrigin = "simulation data"

META$softwareName = "{HM}"
META$softwareVersion = "x"
META$seriesName = "{RCP}"


META$relatedDatasetCitation = "Projections hydrologiques Explore2 du débit pour le modèle {HM} sous {RCP}"
META$relatedDatasetIDType = "doi"
META$relatedDatasetIDNumber = "{DOI}"
META$relatedDatasetURL = "{DOI_URL}"


META$projectAcronym = "Explore2"
META$projectTitle = "Explore2 : Des futurs de l'eau"
META$projectURL = "https://app.inrae.fr/expertise/dossier-le-projet-explore2-des-projections-hydrologiques-pour-adapter-la-gestion-de-la-ressource-en-eau/"


META$timePeriodCoveredStart = "1976-01-01_2005-08-31"
META$timePeriodCoveredEnd = "{HX_period}"

META$country1 = "{country1}"
META$otherGeographicCoverage1 = "{coverage1}"
META$country2 = "{country2}"
META$otherGeographicCoverage2 = "{coverage2}"

META$depositor = "HERAUT, LOUIS"
