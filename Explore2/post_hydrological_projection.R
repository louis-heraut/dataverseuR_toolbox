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
library(dplyr)

dotenv::load_dot_env(file=".env-entrepot")
# dotenv::load_dot_env(file=".env-demo")



to_do = c(
    # "get_metadata"
    "search_datasets",
    # "create_datasets"
    "modify_datasets"
    # "add_files"
    # "delete_files"
    # "delete_datasets"
    # "publish_datasets"
)

dataverse = "explore2-projections_hydrologiques"


if ("get_metadata" %in% to_do) {
    dataset_DOI = "doi:10.57745/VA7KHZ"
    metadata = get_dataset_metadata(dataset_DOI=dataset_DOI)
    convert_metadata(metadata)
}


if ("search_datasets" %in% to_do) {

    cols = c("dataset_DOI",
             "url",
             "name",
             "citation",
             "description",
             "identifier_of_dataverse",
             "subjects",
             "keywords",
             "fileCount",
             "createdAt",
             "authors")
    
    query = "*"
    publication_status = "DRAFT"
    type = "dataset"
    n_search = 1000
    
    datasets_search =
        search(query=query,
               publication_status=publication_status,
               type=type,
               dataverse=dataverse,
               n_search=n_search)
    
    datasets_info = convert_datasets_search_to_tibble(datasets_search)
}

if ("create_datasets" %in% to_do |
    "modify_datasets" %in% to_do) {

    metadata_dir = "metadata_hydrological_projections"
    path_to_data = "/media/lheraut/Explore2/projections_hydrologiques/hydrological-projection_daily-time-series_by-chain_merged-netcdf"
    Dirpaths = list.dirs(path_to_data, recursive=FALSE)
    Dirs = gsub(".*[/]", "", Dirpaths)
    Info_Dirs = strsplit(Dirs, "_")
    
    EXP_all = sapply(Info_Dirs, "[[", 2) 
    EXP = c("RCP 2.6"="historical-rcp26",
            "RCP 4.5"="historical-rcp45",
            "RCP 8.5"="historical-rcp85")
    HM_all = sapply(Info_Dirs, "[[", 3) 
    HM = unique(HM_all)
    HM = HM[HM != "all"]
    
    for (i in 1:length(EXP)) {
        exp = EXP[i]
        exp_name = names(EXP)[i]
        for (hm in HM) {
            metadata_path = file.path(metadata_dir,
                                      paste0(hm, ".R"))
            initialise_metadata()
            source(metadata_path)
            META$title = gsub("[{]RCP[}]",
                              exp_name, META$title)
            META$dsDescriptionValue = gsub("[{]RCP[}]",
                                           exp_name,
                                           META$dsDescriptionValue)
            META$seriesName = gsub("[{]RCP[}]",
                                   exp_name, META$seriesName)
            res = generate_metadata()
            
            if ("create_datasets" %in% to_do) {
                dataset_DOI =
                    create_dataset(dataverse=dataverse,
                                   metadata_path=res$file_path)
            }
            if ("modify_datasets" %in% to_do) {
                dataset_DOI =
                    filter(datasets_info, grepl(exp_name, name) &
                                          grepl(hm, name))$dataset_DOI
                Sys.sleep(1)
                dataset_DOI =
                    modify_dataset_metadata(dataverse=dataverse,
                                            dataset_DOI=dataset_DOI,
                                            metadata_path=res$file_path)
            }
        }
    }
}


if ("add_files" %in% to_do) {
    add_dataset_files(dataset_DOI=dataset_DOI,
                      paths="LICENSE")
}

if ("delete_files" %in% to_do) {
    for (dataset_DOI in datasets_info$dataset_DOI) {
        delete_dataset_files(dataset_DOI=dataset_DOI)
    }
}

if ("delete_datasets" %in% to_do) {
    for (dataset_DOI in datasets_info$dataset_DOI) {
        delete_dataset(dataset_DOI=dataset_DOI)
    }
}


if ("publish_datasets" %in% to_do) {
    publish_dataset(dataset_DOI, type="major")
}





