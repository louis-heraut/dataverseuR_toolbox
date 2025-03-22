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
    "search_datasets"
)


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
    
    query = '(title:"Fiches de résultats*" OR title:"Fiches incertitudes*" OR title:"Fiches de diagnostic*" OR title:"Ensemble des fiches") NOT title:"Notice" NOT title:"Accompagnement"'
    publication_status = "RELEASED"
    type = "dataset"
    n_search = 1000
    
    datasets_search =
        search(query=query,
               publication_status=publication_status,
               type=type,
               dataverse="explore2",
               n_search=n_search)
    
    datasets_info = convert_datasets_search_to_tibble(datasets_search)
    writeLines(datasets_info$dataset_DOI, "DOI_fiche.txt")


    query = 'kindOfDataOther:rapport OR kindOfDataOther:notice'
    publication_status = "RELEASED"
    type = "dataset"
    n_search = 1000
    
    datasets_search =
        search(query=query,
               publication_status=publication_status,
               type=type,
               dataverse="explore2",
               n_search=n_search)
    
    datasets_info = convert_datasets_search_to_tibble(datasets_search)
    datasets_info$name

    writeLines(datasets_info$dataset_DOI, "DOI_rapport.txt")
}






