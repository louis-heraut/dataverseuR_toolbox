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
    "search_datasets"
    # "create_datasets"
    # "modify_datasets"
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

if ("create_datasets" %in% to_do) {

    metadata_template_dir = "metadata_hydrological_projections"
    metadata_filename = "RDG_metadata"
    path_to_data = "/media/lheraut/Explore2/projections_hydrologiques/hydrological-projection_daily-time-series_by-chain_merged-netcdf"
    
    metadata_template_path = file.path(metadata_template_dir, "all.R")
    metadata_path = file.path(path_to_data,
                              paste0(metadata_filename, ".R"))
    
    file.copy(metadata_template_path, metadata_path)
    
    initialise_metadata()
    source(metadata_path)
    res = generate_metadata(out_dir=path_to_data,
                            file_name_overwrite=
                                metadata_filename)
    dataset_DOI =
        create_dataset(dataverse=dataverse,
                       metadata_path=res$file_path)
}


