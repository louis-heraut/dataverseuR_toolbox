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
    "modify_file"
)

dataverse = "explore2-fiches_syntheses"


if ("search_datasets" %in% to_do) {

    query = '"fiches de résultats"'
    publication_status = "RELEASED"
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


if ("modify_file" %in% to_do) {
    datasets_DOI = datasets$dataset_DOI
    new_file_to_add_path = "Notice_fiche_synthese_Explore2.pdf"
    file_to_replace_pattern = "Notice[_]"
    
    for (i in 1:length(datasets_DOI)) {
        dataset_DOI = datasets_DOI[i]
        files = list_datasets_files(dataset_DOI)
        
        Ok = grepl(file_to_replace_pattern, files$label)
        if (!any(Ok)) {
            next
        }
        
        file = dplyr::filter(files,
                             grepl(file_to_replace_pattern,
                                   label))
        file_DOI = file$file_DOI

        delete_datasets_files(file_DOI=file_DOI)
        Sys.sleep(5)
        add_datasets_files(dataset_DOI=dataset_DOI,
                           file_paths=new_file_to_add_path)
        Sys.sleep(5)
        publish_datasets(dataset_DOI=dataset_DOI)
    }
}









