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
                        dataverse="explore2",
                        n_search=n_search)
    datasets = dplyr::distinct(datasets, dataset_DOI,
                               .keep_all=TRUE)
}


if ("get_metrics" %in% to_do) {
    datasets_metrics = get_datasets_metrics(datasets$dataset_DOI)
    datasets = dplyr::full_join(datasets, datasets_metrics,
                                by="dataset_DOI")

    datasets_size = get_datasets_size(datasets$dataset_DOI)
    datasets = dplyr::full_join(datasets, datasets_size,
                                by="dataset_DOI")
    
    ASHE::write_tibble(datasets,
                       path="metrics.csv")
}
 
