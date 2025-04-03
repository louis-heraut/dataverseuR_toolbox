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

dataverse = "DRYvER-WP1-DRN-EU"


if ("search_datasets" %in% to_do) {

    query = "*"
    publication_status = "RELEASED"
    type = "dataset"
    n_search = 1000
    
    datasets =
        search_datasets(query=query,
                        publication_status=publication_status,
                        type=type,
                        dataverse=dataverse,
                        n_search=n_search)
}


if ("modify_file" %in% to_do) {
    datasets_DOI = datasets$DOI

    for (i in 1:length(datasets_DOI)) {

        dataset_DOI = datasets_DOI[i]
        files = list_datasets_files(dataset_DOI)
        file_pattern = "0[_]README[.]txt"
        
        Ok = grepl(file_pattern, files$label)
        if (!any(Ok)) {
            next
        }
        
        file = dplyr::filter(files, grepl(file_pattern, label))
        file_DOI = file$DOI
        file_name = file$label

        download_datasets_files(files_DOI=file_DOI,
                                save_paths=file_name)
        
        Lines = readLines(file_name)
        Ok = grepl("preprint", Lines)
        
        if (any(Ok)) {
            id = which(Ok)
            Lines[id] = "Mimeau, L., Künne, A., Devers, A., Branger, F., Kralisch, S., Lauvernet, C., Vidal, J.-P., Bonada, N., Csabai, Z., Mykrä, H., Pařil, P., Polović, L., and Datry, T.: Projections of streamflow intermittence under climate change in European drying river networks, Hydrol. Earth Syst. Sci., 29, 1615–1636, https://doi.org/10.5194/hess-29-1615-2025, 2025."
            writeLines(Lines, file_name)

            delete_datasets_files(files_DOI=file_DOI)
            add_dataset_files(dataset_DOI=dataset_DOI,
                              paths=file_name)

            publish_datasets(datasets_DOI=dataset_DOI)
        }
    }
}









