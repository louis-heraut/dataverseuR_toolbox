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
    "modify_datasets" %in% to_do |
    "add_files" %in% to_do) {

    nEXP_start = 3
    nHM_start = 9

    metadata_template_dir = "metadata_hydrological_projections"
    metadata_filename = "RDG_metadata"
    path_to_data = "/media/lheraut/Explore2/projections_hydrologiques/hydrological-projection_daily-time-series_by-chain_merged-netcdf"
    Dirpaths = list.dirs(path_to_data, recursive=FALSE)
    Dirs = gsub(".*[/]", "", Dirpaths)
    Info_Dirs = strsplit(Dirs, "_")
    
    EXP_all = sapply(Info_Dirs, "[[", 2) 
    EXP = c("RCP 2.6"="historical-rcp26",
            "RCP 4.5"="historical-rcp45",
            "RCP 8.5"="historical-rcp85")
    nEXP = length(EXP)
    
    HM_all = sapply(Info_Dirs, "[[", 3) 
    HM = unique(HM_all)
    HM = HM[HM != "all"]
    nHM = length(HM)
    
    for (i in nEXP_start:nEXP) {
        exp = EXP[i]
        exp_name = names(EXP)[i]

        for (j in nHM_start:nHM) {
            hm = HM[j]
            
            output_dirpath = Dirpaths[grepl(exp, Dirs) &
                                      grepl(hm, Dirs)]
            
            if ("create_datasets" %in% to_do |
                "modify_datasets" %in% to_do) {
                metadata_template_path =
                    file.path(metadata_template_dir,
                              paste0(hm, ".R"))
                metadata_file = readLines(metadata_template_path)
                metadata_file = gsub("[{]RCP[}]",
                                     exp_name, metadata_file)
                metadata_path = file.path(output_dirpath,
                                          paste0(metadata_filename,
                                                 ".R"))
                writeLines(metadata_file, metadata_path)
                
                initialise_metadata()
                source(metadata_path)
                res = generate_metadata(out_dir=output_dirpath,
                                        file_name_overwrite=
                                            metadata_filename)
            }

            if ("create_datasets" %in% to_do) {
                dataset_DOI =
                    create_dataset(dataverse=dataverse,
                                   metadata_path=res$file_path)
            }

            if ("modify_datasets" %in% to_do |
                "add_files" %in% to_do) {
                dataset_DOI =
                    filter(datasets_info, grepl(exp_name, name) &
                                          grepl(hm, name))$dataset_DOI
            }
            
            if ("modify_datasets" %in% to_do) {
                Sys.sleep(4)
                dataset_DOI =
                    modify_dataset_metadata(dataverse=dataverse,
                                            dataset_DOI=dataset_DOI,
                                            metadata_path=res$file_path)
            }
            if ("add_files" %in% to_do) {
                Paths_nc = list.files(output_dirpath,
                                      pattern=".nc",
                                      full.names=TRUE)
                add_dataset_files(dataset_DOI=dataset_DOI,
                                  paths=Paths_nc)
            }
        }
        # stop()
    }
}


# modify_dataset_metadata = function (dataverse, dataset_DOI,
#                                     metadata_path,
#                                     BASE_URL = Sys.getenv("BASE_URL"), 
#                                     API_TOKEN = Sys.getenv("API_TOKEN")) {
#     metadata_json = jsonlite::fromJSON(metadata_path, simplifyDataFrame = FALSE, 
#                                        simplifyVector = FALSE)
#     modify_url = paste0(BASE_URL, "/api/datasets/:persistentId/versions/:draft?persistentId=", 
#                         dataset_DOI)
#     response = httr::PUT(modify_url, httr::add_headers(`X-Dataverse-key` = API_TOKEN), 
#                          body = metadata_json$datasetVersion, encode = "json")
    
#     if (httr::status_code(response) != 200) {
#         cat("Failed to add/update metadata.\n")
#         cat("Status code: ", httr::status_code(response), "\n")
#         cat("Response content: ", httr::content(response, as = "text", 
#                                                 encoding = "UTF-8"), "\n")
#         stop("Error during metadata addition.")
#     }
#     dataset_info = httr::content(response, "parsed")
#     dataset_DOI_URL = gsub("doi[:]", "https://doi.org/", dataset_DOI)
#     message(paste0("Dataset of DOI ", dataset_DOI, " has been modify in ", 
#                    BASE_URL, "/dataverse/", dataverse, " at ", dataset_DOI_URL))
#     return(dataset_DOI)
# }




# if ("add_files" %in% to_do) {
    # add_dataset_files(dataset_DOI=dataset_DOI,
                      # paths="LICENSE")
# }

if ("delete_files" %in% to_do) {
    dataset_DOI = "doi:10.57745/UBCMZK"
    delete_dataset_files(dataset_DOI=dataset_DOI)
}

if ("delete_datasets" %in% to_do) {
    for (dataset_DOI in datasets_info$dataset_DOI) {
        delete_dataset(dataset_DOI=dataset_DOI)
    }
}


if ("publish_datasets" %in% to_do) {
    publish_dataset(dataset_DOI, type="major")
}


