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
    metadata = get_datasets_metadata(dataset_DOI=dataset_DOI)
    convert_metadata(metadata)
}


if ("search_datasets" %in% to_do) {

    query = 'title:"ensemble des projections"'
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
    "modify_datasets" %in% to_do) {

    metadata_template_dir = "metadata_hydrological_projections"
    metadata_filename = "RDG_metadata"
    path_to_data = "/media/lheraut/Explore2/projections_hydrologiques/hydrological-projection_daily-time-series_by-chain_merged-netcdf"
    
    metadata_template_path = file.path(metadata_template_dir, "all.R")
    metadata_path = file.path(path_to_data,
                              paste0(metadata_filename, ".R"))
    
    file.copy(metadata_template_path, metadata_path)
    
    initialise_metadata()
    source(metadata_template_path)
    res = generate_metadata(metadata_dir=path_to_data,
                            metadata_filename=
                                metadata_filename)
    
    if ("create_datasets" %in% to_do) {
        dataset_DOI =
            create_datasets(dataverse=dataverse,
                            metadata_path=res$metadata_path)
    }
    if ("modify_datasets" %in% to_do) {
        dataset_DOI = datasets$dataset_DOI
        modify_datasets(dataverse=dataverse,
                        dataset_DOI=dataset_DOI,
                        metadata_path=res$metadata_path)
    }
    
}







