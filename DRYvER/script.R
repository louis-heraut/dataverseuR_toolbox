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
    # "get_metadata"
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
                        dataverse="DRYvER-WP1-DRN-EU",
                        n_search=n_search)
    
    ASHE::write_tibble(datasets_info,
                       "DRYvER-WP1-DRN-EU_dataset_info.csv")
}


if ("get_metadata" %in% to_do) {
    dataset_DOI = "doi:10.57745/BUPQQF"
    metadata = get_datasets_metadata(datasets_DOI=dataset_DOI)
    convert_metadata(metadata)
}
