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
    # "modify_datasets"
    # "add_netcdf"
    # "add_readme"
    # "rename_files"
    # "delete_files"
    # "delete_readme"
    # "delete_datasets"
    "publish_datasets"
)

dataverse = "explore2-projections_hydrologiques"
path_to_data = "/media/lheraut/Explore2/projections_hydrologiques/hydrological-projection_daily-time-series_by-chain_merged-netcdf"

if ("get_metadata" %in% to_do) {
    dataset_DOI = "doi:10.57745/VA7KHZ"
    metadata = get_datasets_metadata(dataset_DOI=dataset_DOI)
    convert_metadata(metadata)
}


if ("search_datasets" %in% to_do) {
    
    query = 'title:"RCP"'
    publication_status = "DRAFT"
    type = "dataset"
    n_search = 1000
    
    datasets =
        search_datasets(query=query,
                        publication_status=publication_status,
                        type=type,
                        dataverse=dataverse,
                        n_search=n_search)
    datasets
}


if ("create_datasets" %in% to_do |
    "modify_datasets" %in% to_do |
    "add_netcdf" %in% to_do |
    "add_readme" %in% to_do) {

    nEXP_start = 1
    nHM_start = 1

    metadata_template_dir = "metadata_hydrological_projections"
    metadata_filename = "RDG_metadata"
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
                res = generate_metadata(metadata_dir=output_dirpath,
                                        metadata_filename=
                                            metadata_filename)
            }

            if ("create_datasets" %in% to_do) {
                dataset_DOI =
                    create_datasets(dataverse=dataverse,
                                    metadata_paths=
                                        res$metadata_path)
            }

            if ("modify_datasets" %in% to_do |
                "add_netcdf" %in% to_do |
                "add_readme" %in% to_do) {
                dataset = filter(datasets, grepl(exp_name, name) &
                                           grepl(hm, name))
                dataset_DOI = dataset$dataset_DOI
                dataset_citation = gsub("Gouv.*", "Gouv",
                                        dataset$citation)
            }
            
            if ("modify_datasets" %in% to_do) {
                Sys.sleep(4)
                dataset_DOI =
                    modify_datasets(dataverse=dataverse,
                                    dataset_DOI=dataset_DOI,
                                    metadata_paths=res$metadata_path)
            }
            if ("add_netcdf" %in% to_do) {
                nc_Paths = list.files(output_dirpath,
                                      pattern=".nc",
                                      full.names=TRUE)
                add_dataset_files(dataset_DOI=dataset_DOI,
                                  paths=nc_Paths)
            }
            if ("add_readme" %in% to_do) {
                README_template_path =
                    file.path(metadata_template_dir, "README.txt")
                
                README_file = readLines(README_template_path)
                id = which(grepl("[{]CITE[}]", README_file))
                README_file = c(README_file[1:(id-1)],
                                strwrap(dataset_citation, width=70),
                                README_file[(id+1):length(README_file)])
                README_file = gsub("[{]HM[}]",
                                   hm, README_file)
                README_file = gsub("[{]RCP[}]",
                                   exp_name, README_file)
                README_path = file.path(output_dirpath,
                                        "README.txt")
                writeLines(README_file, README_path)
                add_datasets_files(dataset_DOI=dataset_DOI,
                                   file_paths=README_path)
            }
        }
        # stop()
    }
}

if ("rename_files" %in% to_do) {
    datasets_DOI = datasets$dataset_DOI

    Paths_nc = list.files(path_to_data,
                          pattern=".nc",
                          full.names=TRUE,
                          recursive=TRUE)
    Paths_nc = Paths_nc[!grepl("SAFRAN", dirname(Paths_nc))]
    
    Files_nc = basename(Paths_nc)
    Files_nc_cut = sapply(lapply(strsplit(Files_nc, "_"),
                                 "[", 1:10), paste0,
                          collapse="_")
    
    for (dataset_DOI in datasets_DOI) {
        files = list_datasets_files(dataset_DOI)
        files = dplyr::filter(files,
                              gsub(".*[.]", "", label) == "nc")
        files$new_name = NA

        nFiles = nrow(files)
        for (i in 1:nFiles) {
            file = files[i, ]
            fID = file$id
            name = file$label
            name_cut =
                paste0(unlist(strsplit(name, "_"))[1:10],
                       collapse="_")
            path_nc = Paths_nc[Files_nc_cut == name_cut]
            
            NC = ncdf4::nc_open(path_nc)
            min_date = min(ncdf4::ncvar_get(NC, "time") +
                           as.Date("1950-01-01"))
            min_date = format(min_date, "%Y%m%d")
            ncdf4::nc_close(NC)

            new_name = unlist(strsplit(name, "_"))
            new_period =
                paste0(min_date,
                       gsub(".*[-]", "-",
                            new_name[11]))
            new_name[11] = new_period
            new_name = paste0(new_name, collapse="_")

            rename_datasets_files(file_DOI=fID,
                                  new_name=new_name,
                                  is_DOI_ID=TRUE)
            
            new_path_nc = file.path(dirname(path_nc),
                                    new_name)
            file.rename(from=path_nc, to=new_path_nc)
        }
    }
}


if ("delete_files" %in% to_do) {
    dataset_DOI = "doi:10.57745/UBCMZK"
    delete_all_datasets_files(dataset_DOI=dataset_DOI)
}


if ("delete_readme" %in% to_do) {
    files = list_datasets_files(datasets$dataset_DOI)
    readmes = dplyr::filter(files, grepl("README", label))
    delete_datasets_files(file_DOI=readmes$id,
                          is_DOI_ID=TRUE)
}


if ("delete_datasets" %in% to_do) {
    delete_datasets(dataset_DOI=dataset_DOI)
}

if ("publish_datasets" %in% to_do) {
    publish_datasets(dataset_DOI=datasets$dataset_DOI, type="major")
}


