# Copyright 2025 Louis Héraut (louis.heraut@inrae.fr)*1
#
# *1   INRAE, France
#
# This file is part of dataverseur R package.
#
# dataverseur R package is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
#
# dataverseur R package is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU xGeneral Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with dataverseur R package.
# If not, see <https://www.gnu.org/licenses/>.


library(dataverseuR)

dotenv::load_dot_env(file=".env-entrepot")
# dotenv::load_dot_env(file=".env-demo")


to_do = c(
    "search_datasets",
    "get_metrics"
    # "get_save_data",
    # "plot_data"
)


if ("search_datasets" %in% to_do) {

    query = "*"
    publication_status = "RELEASED"
    type = "dataset"
    n_search = 1000
    
    datasets =
        search_datasets(query=query,
                        publication_status=publication_status,
                        type=type,
                        dataverse="riverly",
                        n_search=n_search)
    
    datasets_tmp =
        search_datasets(query=query,
                        publication_status=publication_status,
                        type=type,
                        dataverse="BDOH",
                        n_search=n_search)
    datasets = dplyr::bind_rows(datasets, datasets_tmp)
    
    datasets_tmp =
        search_datasets(query=query,
                        publication_status=publication_status,
                        type=type,
                        dataverse="explore2",
                        n_search=n_search)
    datasets = dplyr::bind_rows(datasets, datasets_tmp)

    datasets = dplyr::distinct(datasets, dataset_DOI,
                               .keep_all=TRUE)
}


if ("get_metrics" %in% to_do) {
    datasets_metrics = get_datasets_metrics(datasets$DOI)
    datasets = dplyr::full_join(datasets, datasets_metrics,
                                by="dataset_DOI")

    datasets_size = get_datasets_size(datasets$DOI)
    datasets = dplyr::full_join(datasets, datasets_size,
                                by="dataset_DOI")
    
    ASHE::write_tibble(datasets,
                       path="datasets.csv")
}
 

if ("get_save_data" %in% to_do) {
    data = ASHE::read_tibble("datasets_updated.csv")
    data$createdAt = as.Date(substr(data$createdAt, 1, 10))
    data$authors = stringr::str_to_title(ASHE::clean_path(data$authors))
    data = dplyr::filter(data,
                         as.Date("2019-01-01") <= createdAt &
                         createdAt <= as.Date("2024-12-31"))
    # ASHE::write_tibble(data, "datasets_updated.csv")
}


if ("plot_data" %in% to_do) {
    library(ggplot2)
    library(dplyr)

    # library(showtext)
    # family = "Lato"
    # font_add_google(name=family,
    #                 family=family)
    
    library(extrafont)
    # font_import(paths="/home/lheraut/Documents/autre/police/Lato",
    # prompt=FALSE)
    loadfonts(quiet=TRUE)

    dataSHEEP::assign_colors_and_fonts()

    data_project = summarise(group_by(data, project),
                             n_dataset=n(),
                             n_fileCount=sum(fileCount,
                                             na.rm=TRUE),
                             n_viewsTotal=sum(viewsTotal,
                                              na.rm=TRUE),
                             n_downloadsTotal=sum(downloadsTotal,
                                                  na.rm=TRUE),
                             n_storage_size_GB=sum(storage_size_GB,
                                                   na.rm=TRUE))
    
    
    # Nombre de jeux de donnée par an
    data$createdAt_year = lubridate::year(data$createdAt)

    data_year = summarise(group_by(data, createdAt_year),
                         n_dataset=n())

    data_year_hors_RDG =
        summarise(group_by(filter(data,
                                  project!="Explore2"),
                           createdAt_year),
                  n_dataset=n())

    data_year_RDG_sans_Explore2 =
        summarise(group_by(filter(data,
                                  plateforme=="RDG" &
                                  project!="Explore2"),
                           createdAt_year),
                  n_dataset=n())
    
    data_year_RDG_Explore2 =
        summarise(group_by(data, createdAt_year),
                  n_dataset=n())
    
    plot = ggplot() +
        dataSHEEP::theme_IPCC(family=family) +
        ggtitle("Nombre de jeux de donnée par an") +
        xlab("Année") + ylab("") +
        
        geom_bar(data=data_year_RDG_Explore2,
                 aes(x=createdAt_year, y=n_dataset),
                 stat="identity", width=0.4,
                 fill=EXPLORE2blue, color="white") +
        geom_bar(data=data_year_hors_RDG,
                 aes(x=createdAt_year, y=n_dataset),
                 stat="identity", width=0.4,
                 fill=IPCCgrey75, color="white") +
        geom_bar(data=data_year_RDG_sans_Explore2,
                 aes(x=createdAt_year, y=n_dataset),
                 stat="identity", width=0.4,
                 fill=IPCCgrey48, color="white") +
        
        annotate("rect",
                 xmin=2018.8,
                 xmax=2022.35,
                 ymin=61,
                 ymax=79,
                 fill="white", color="white") +
    
        annotate("point",
                 x=min(data_year$createdAt_year),
                 y=75, shape=22, size=4,
                 fill=EXPLORE2blue, color="white") +
        annotate("text",
                 x=min(data_year$createdAt_year)+0.2,
                 y=75, label="Recherche Data Gouv avec Explore2",
                 color=EXPLORE2blue, size=3.5,
                 hjust=0, family=family) +
        
        annotate("point",
                 x=min(data_year$createdAt_year),
                 y=70, shape=22, size=4,
                 fill=IPCCgrey48, color="white") +
        annotate("text",
                 x=min(data_year$createdAt_year)+0.2,
                 y=70, label="Recherche Data Gouv sans Explore2",
                 color=IPCCgrey48, size=3.5,
                 hjust=0, family=family) +
    
        annotate("point",
                 x=min(data_year$createdAt_year),
                 y=65, shape=22, size=4,
                 fill=IPCCgrey75, color="white") +
        annotate("text",
                 x=min(data_year$createdAt_year)+0.2,
                 y=65, label="Autre entrepôt",
                 color=IPCCgrey60, size=3.5,
                 hjust=0, family=family) +
        
        scale_x_continuous(breaks=data_year$createdAt_year) +
        scale_y_continuous(limits=c(0, NA), expand=c(0, NA),
                           breaks=scales::pretty_breaks(n=10))
    
        ggplot2::ggsave(plot=plot,
                        path="figures",
                        filename="n_dataset_per_year.pdf",
                        width=12, height=12, units='cm',
                        dpi=300, device=cairo_pdf)


    # Nombre de jeux de donnée par an
    data$createdAt_year = lubridate::year(data$createdAt)

    data_year = summarise(group_by(data, createdAt_year),
                         n_viewsTotal=sum(viewsTotal,
                                          na.rm=TRUE))

    # views : Explore2 / perennial / PIRAGUA / shallow / family / Gammarus
    data_year_no_project =
        summarise(group_by(filter(data,
                                  !grepl("Explore2", project) &
                                  !grepl("perennial", project) &
                                  !grepl("PIRAGUA", project) &
                                  !grepl("shallow", project) &
                                  !grepl("family", project) &
                                  !grepl("Gammarus", project)),
                           createdAt_year),
                  n_viewsTotal=sum(viewsTotal,
                                   na.rm=TRUE))

    data_year_Explore2 =
        summarise(group_by(filter(data,
                                  !grepl("perennial", project) &
                                  !grepl("PIRAGUA", project) &
                                  !grepl("shallow", project) &
                                  !grepl("family", project) &
                                  !grepl("Gammarus", project)),
                           createdAt_year),
                  n_viewsTotal=sum(viewsTotal,
                                   na.rm=TRUE))

    data_year_perennial =
        summarise(group_by(filter(data,
                                  !grepl("PIRAGUA", project) &
                                  !grepl("shallow", project) &
                                  !grepl("family", project) &
                                  !grepl("Gammarus", project)),
                           createdAt_year),
                  n_viewsTotal=sum(viewsTotal,
                                   na.rm=TRUE))

    data_year_PIRAGUA =
        summarise(group_by(filter(data,
                                  !grepl("shallow", project) &
                                  !grepl("family", project) &
                                  !grepl("Gammarus", project)),
                           createdAt_year),
                  n_viewsTotal=sum(viewsTotal,
                                   na.rm=TRUE))

    data_year_shallow =
        summarise(group_by(filter(data,
                                  !grepl("family", project) &
                                  !grepl("Gammarus", project)),
                           createdAt_year),
                  n_viewsTotal=sum(viewsTotal,
                                   na.rm=TRUE))

    data_year_family =
        summarise(group_by(filter(data,
                                  !grepl("Gammarus", project)),
                           createdAt_year),
                  n_viewsTotal=sum(viewsTotal,
                                   na.rm=TRUE))

    data_year_Gammarus =
        summarise(group_by(data,
                           createdAt_year),
                  n_viewsTotal=sum(viewsTotal,
                                   na.rm=TRUE))

    plot = ggplot() +
        dataSHEEP::theme_IPCC(family=family) +
        ggtitle("Nombre de vues totales par an") + 
        xlab("Année") + ylab("") +
        
        geom_bar(data=data_year_Gammarus,
                 aes(x=createdAt_year, y=n_viewsTotal),
                 stat="identity", width=0.4,
                 fill="#A8D5A2", color="white") +
        
        geom_bar(data=data_year_family,
                 aes(x=createdAt_year, y=n_viewsTotal),
                 stat="identity", width=0.4,
                 fill="#4E5F68", color="white") +
        
        geom_bar(data=data_year_shallow,
                 aes(x=createdAt_year, y=n_viewsTotal),
                 stat="identity", width=0.4,
                 fill="#B9A5D8", color="white") +
        
        geom_bar(data=data_year_PIRAGUA,
                 aes(x=createdAt_year, y=n_viewsTotal),
                 stat="identity", width=0.4,
                 fill="#C0373C", color="white") +
        
        geom_bar(data=data_year_perennial,
                 aes(x=createdAt_year, y=n_viewsTotal),
                 stat="identity", width=0.4,
                 fill="#EBAC32", color="white") +
        
        geom_bar(data=data_year_Explore2,
                 aes(x=createdAt_year, y=n_viewsTotal),
                 stat="identity", width=0.4,
                 fill=EXPLORE2blue, color="white") +
        
        geom_bar(data=data_year_no_project,
                 aes(x=createdAt_year, y=n_viewsTotal),
                 stat="identity", width=0.4,
                 fill=IPCCgrey67, color="white") +
        
        annotate("rect",
                 xmin=2018.8,
                 xmax=2023.4,
                 ymin=26000,
                 ymax=62000,
                 fill="white", color="white") +
        
        annotate("point",
                 x=min(data_year$createdAt_year),
                 y=60000, shape=22, size=4,
                 fill=EXPLORE2blue, color="white") +
        annotate("text",
                 x=min(data_year$createdAt_year)+0.2,
                 y=60000, label="Explore2",
                 color=EXPLORE2blue, size=3,
                 hjust=0, family=family) +
        
        annotate("point",
                 x=min(data_year$createdAt_year),
                 y=55000, shape=23, size=3.4,
                 fill="#EBAC32", color="white") +
        annotate("text",
                 x=min(data$createdAt_year)+0.2,
                 y=55000,
                 label="Global prevalence of non-perennial rivers and streams",
                 color="#EBAC32", size=3,
                 hjust=0, family=family) +
        
        annotate("point",
                 x=min(data_year$createdAt_year),
                 y=50200, shape=22, size=4,
                 fill="#C0373C", color="white") +
        annotate("text",
                 x=min(data_year$createdAt_year)+0.2,
                 y=50200, label="PIRAGUA",
                 color="#C0373C", size=3,
                 hjust=0, family=family) +
        
        annotate("point",
                 x=min(data_year$createdAt_year),
                 y=43600, shape=23, size=3.4,
                 fill="#B9A5D8", color="white") +
        annotate("text",
                 x=min(data_year$createdAt_year)+0.2,
                 y=45500,
                 label="Laboratory experiment on shallow mixing layers",
                 color="#B9A5D8", size=3,
                 hjust=0, family=family) +
        annotate("text",
                 x=min(data_year$createdAt_year)+0.2,
                 y=42000,
                 label="over smooth bed in a tilted open channel",
                 color="#B9A5D8", size=3,
                 hjust=0, family=family) +

        annotate("point",
                 x=min(data_year$createdAt_year),
                 y=36700, shape=23, size=3.4,
                 fill="#4E5F68", color="white") +
        annotate("text",
                 x=min(data_year$createdAt_year)+0.2,
                 y=38000,
                 label="Continuous measurement of the volumes discharged",
                 color="#4E5F68", size=3,
                 hjust=0, family=family) +
        annotate("text",
                 x=min(data_year$createdAt_year)+0.2,
                 y=34700,
                 label="from three French single-family homes",
                 color="#4E5F68", size=3,
                 hjust=0, family=family) +
    
        annotate("point",
                 x=min(data_year$createdAt_year),
                 y=31000, shape=23, size=3.4,
                 fill="#A8D5A2", color="white") +
        annotate("text",
                 x=min(data_year$createdAt_year)+0.2,
                 y=30900,
                 label="Experimental test of Gammarus fossarum",
                 color="#A8D5A2", size=3,
                 hjust=0, family=family) +
        annotate("text",
                 x=min(data_year$createdAt_year)+0.2,
                 y=27900,
                 label="sentitivity to hypoxic stress",
                 color="#A8D5A2", size=3,
                 hjust=0, family=family) +
    
        scale_x_continuous(breaks=data_year$createdAt_year) +
        scale_y_sqrt(expand=c(0, NA),
                     breaks=scales::pretty_breaks(n=10),
                     labels=scales::label_number(big.mark=" "))
    
        ggplot2::ggsave(plot=plot,
                        path="figures",
                        filename="n_viewsTotal_per_year.pdf",
                        width=12, height=12, units='cm',
                        dpi=300, device=cairo_pdf)

    # keywords
    KeywordsALL = gsub("(^ )|( $)|( )", "",
                    unlist(strsplit(data$keywords, ";")))
    KeywordsALL = tolower(KeywordsALL)
    KeywordsALL = unique(KeywordsALL)

    
    Keywords = list(
        "Hydrology and Hydrogeology"=c(
            "hydrology",
            "surfacewater hydrology",
            "hydrogeology",
            "river flow",
            "réseau de référence",
            "groundwater",
            "groundwater level",
            "infiltration",
            "recharge",
            "recharge de la nappe",
            "aquifère",
            "AquiFr",
            "hydrological modelling",
            "modélisation hydrologique",
            "modélisation hydrogéologique",
            "hydrogeological projection",
            "hydrological projection",
            "HydroPortail",
            "niveau piézométrique",
            "hydrométrie",
            "débit de cours d'eau",
            "chronic hydrologique",
            "bassin versant expérimental",
            "pluie efficace",
            "infiltration experiments",
            "soil hydraulic properties",
            "hydrological regime",
            "modélisation",
            "observation",
            "maillage",
            "point",
            "hydro",
            "hydrologie de surface",
            "assec",
            "intermittent rivers",
            "temporary river",
            "flow permanence",
            "intermittency",
            "non-perennial",
            "hydrological alterations"
        ),
        "Aquatic Ecosystems and Biodiversity"=c(
            "aquatic fauna",
            "écosystème ripisylve",
            "vegetation",
            "macrophytes",
            "biodiversity",
            "amphibians",
            "odonata",
            "gammarus",
            "biota",
            "sentinel species",
            "fish assemblage",
            "biomonitoring",
            "active biomonitoring",
            "ecology",
            "environmental DNA (eDNA)",
            "fungi",
            "eukaryota",
            "bacteria",
            "collembola",
            "insecta",
            "oligochaeta",
            "spermatophyta",
            "vascular plants",
            "springtails",
            "earthworms",
            "freshwater biodiversity crisis",
            "freshwater conservation",
            "rivers",
            "streams",
            "intermittent rivers",
            "temporary river",
            "flow permanence",
            "intermittency",
            "non-perennial"
        ),
        "Water Quality and Contamination"=c(
            "water quality",
            "pollution",
            "pollution agricole diffuse",
            "pesticide",
            "organic micropollutant",
            "emerging substance",
            "drug",
            "PESHMELBA",
            "phytopharmaceutical",
            "chemical contamination",
            "metal",
            "contamination",
            "bioaccumulation",
            "dissolved organic matter",
            "fluorescence spectroscopy",
            "suspect screening",
            "transformation product",
            "in silico predictor",
            "environmental impact",
            "ecotoxicology",
            "environmental engineering",
            "solid gauging",
            "suspended sediment",
            "suspended sand"
        ),
        "Climate Change Impacts and Adaptation"=c(
            "climate change",
            "impact du changement climatique",
            "climate change adaptation",
            "climate change mitigation",
            "climate",
            "climat régional",
            "projections hydro-climatiques",
            "climate data",
            "climate scenarios",
            "climatic scenarios",
            "hydrological projection",
            "hydrogeological projection",
            "precipitation",
            "précipitation atmosphérique",
            "temperature",
            "adaptation",
            "droughts",
            "sécheresse",
            "flood",
            "étiage",
            "pluie extrême",
            "RCP",
            "climate scenarios",
            "climate mitigation"
        ),
        "Hydraulic, Geomorphology and Sediment"=c(
            "geomorphology",
            "morphologie des cours d'eau",
            "sediment transport",
            "sediment",
            "erosion",
            "badlands",
            "suspended sediment",
            "sand",
            "down woody debris",
            "flash flood",
            "river dynamics",
            "river flooding",
            "transient flow",
            "floodplain",
            "flood",
            "shallow flows",
            "flow intrusion",
            "unsteady flow",
            "porosity",
            "shallow turbulent flow",
            "mixing layer",
            "suspended sand",
            "LSPIV",
            "ADCP"
        ),
        "Water Resource Management and Policy"=c(
            "water resource management",
            "Integrated Water Resources Management (IWRM)",
            "sustainable development goals (SDG)",
            "SDG 6.4",
            "water scarcity",
            "water stress",
            "water use and efficiency",
            "flow regulation",
            "instream flow management",
            "environmental water",
            "hydroelectric engineering",
            "periurban areas",
            "rural area",
            "buffer zone",
            "disponibilité en eau",
            "connaissance et freins",
            "collective scientific assessment"
        ),
        "Environmental Monitoring and Data Analysis"=c(
            "database",
            "long-term monitoring",
            "random forest",
            "GIS",
            "RiverATLAS",
            "HydroATLAS",
            "HydroSHEDS",
            "hydrométrie",
            "velocimétrie par image de particules",
            "LSPIV",
            "ADCP",
            "gauging station",
            "reanalysis",
            "reconstruction",
            "hydrology",
            "SWAT",
            "machine learning modeling",
            "analyse de tendance",
            "test de Mann-Kendall",
            "sensitivity analysis",
            "distributed modeling",
            "fiche diagnostic",
            "fiche résultat",
            "fiches incertitudes"
        ),
        "Soil-Plant-Water Interactions"=c(
            "soil moisture",
            "soil temperature",
            "soil",
            "soil texture",
            "soil hydraulic properties",
            "dry bulk density",
            "hydraulic conductivity",
            "evapotranspiration",
            "infiltration",
            "vegetation",
            "flux",
            "concentration",
            "sampling",
            "biogeochemistry"
        ),
        "Extreme Events : Floods and Droughts"=c(
            "flood risk",
            "flash flood",
            "urban flooding",
            "droughts",
            "sécheresse",
            "étiage",
            "extreme rainfall",
            "river flooding",
            "flood",
            "regime de crue",
            "sewer overflow",
            "urban hydrology"
        ),
        "Critical Zone and Land-Use Interactions"=c(
            "critical zone",
            "rural area",
            "periurban areas",
            "land use",
            "bassin versant expérimental",
            "watershed",
            "buffer zone",
            "river system",
            "intersection",
            "environmental science",
            "physical geography"
        )
    )

    n_Keywords = sapply(Keywords, length) 
    data_keyword = tibble(
        categorie=
            c("Hydrology and Hydrogeology", 
              "Aquatic Ecosystems and Biodiversity",
              "Water Quality and Contamination",
              "Climate Change Impacts and Adaptation",
              "Hydraulic, Geomorphology and Sediment",
              "Water Resource Management and Policy",
              "Environmental Monitoring and Data Analysis",
              "Soil-Plant-Water Interactions",
              "Extreme Events : Floods and Droughts",
              "Critical Zone and Land-Use Interactions"),
        categorie_line=list(
            c("Hydrology and", "Hydrogeology"),
            c("Aquatic", "Ecosystems", "and Biodiversity"),
            c("Water Quality", "and Contamination"),
            c("Climate Change", "Impacts", "and Adaptation"),
            c("Hydraulic,", "Geomorphology", "and Sediment"), #5
            c("Water", "Resource", "Management", "and Policy"),
            c("Environmental", "Monitoring", "and Data Analysis"),
            c("Soil-Plant-Water", "Interactions"),
            c("Extreme Events :", "Floods and Droughts"),
            c("Critical", "Zone and", "Land-Use", "Interactions")),
        size=c(4, 4, 3.5, 3.5, 3.5,
               3, 3.5, 3, 3, 2.2),
        color=c("#4A769D",
                "#76B5A7",
                "#7FBFFF",
                "#E89B84",
                "#B29A8F",#5
                "#6D8BAE",
                "#9AA1A7",
                "#9BBF8C",
                "#D97777",
                "#B7BFA5"),
        color_light=c("#a0bbd2",
                      "#badad3",
                      "#bfdfff",
                      "#f3cdc1",
                      "#d8ccc7",#5
                      "#b6c5d6",
                      "#cdd0d3",
                      "#cddfc5",
                      "#ecbbbb",
                      "#dbdfd2"),
        n_keyword=n_Keywords,
        keywords=Keywords,
        n_keyword_cut=c(29, 28, 15, 10, 16,
                        6, 16, 6, 5, 9))


    data_plot = treemap::treemap(data_keyword,
                                 index="categorie",
                                 vSize="n_keyword",
                                 type="index",
                                 algo="squarified",
                                 aspRatio=1)$tm

    data_keyword = full_join(data_keyword,
                             select(data_plot,
                                    categorie,
                                    x0, y0, w, h),
                             by="categorie")

    pad = 0.5
    newline_keyword = 0.018
    width_fact_keyword = 100

    
    plot = ggplot() + theme_void()

    for (i in 1:nrow(data_keyword)) {
        rect = data_keyword[i,]
        plot = plot +
            annotate("rect",
                     xmin=rect$x0,
                     xmax=rect$x0+rect$w,
                     ymin=rect$y0,
                     ymax=rect$y0+rect$h,
                     size=1,
                     color="white",
                     fill=rect$color)

        keywords = unlist(rect$keywords)
        keywords = keywords[1:min(rect$n_keyword_cut,
                                  length(keywords))]
        keywords = paste(keywords, collapse=", ")
        keywords_line = strwrap(keywords,
                                width=round(rect$w*width_fact_keyword))
        nLine = length(keywords_line)
        for (j in 1:nLine) {
            plot = plot +
                annotate("text",
                         x=rect$x0+pad*rect$size/100,
                         y=rect$y0+rect$h-pad*rect$size/100 -
                             (j-1)*newline_keyword,
                         label=keywords_line[j],
                         size=2,
                         family="Lato",
                         hjust=0, vjust=1,
                         color=rect$color_light)
        }
        
        categorie_line = unlist(rect$categorie_line)
        nLine = length(categorie_line)
        for (j in 1:nLine) {
            plot = plot +
                annotate("text",
                         x=rect$x0+pad*rect$size/100,
                         y=rect$y0+pad*rect$size/100 +
                             (nLine-j)*rect$size/100 +
                             rect$size/100,
                         label=categorie_line[j],
                         size=rect$size,
                         family="Lato Black",
                         hjust=0, vjust=0,
                         color="white")
        }
        plot = plot +
            annotate("text",
                     x=rect$x0+pad*rect$size/100,
                     y=rect$y0+pad*rect$size/100,
                     label=paste0(rect$n_keyword,
                                  " mots-clés"),
                     size=rect$size,
                     family="Lato Bold",
                     hjust=0, vjust=0,
                     color="white")
        
        
        
    }
    ggplot2::ggsave(plot=plot,
                    path="figures",
                    filename="keywords_treemap.pdf",
                    width=12, height=12, units='cm',
                    dpi=300, device=cairo_pdf)
    

}



# library(plotly)
# plot_ly(
#   type = "treemap",
#   labels = names(Keywords),
#   values = n_Keywords,
#   parents = rep("", length(Keywords)),  # No hierarchical parent
#   marker = list(colors = RColorBrewer::brewer.pal(length(Keywords), "Set2"))
# )
