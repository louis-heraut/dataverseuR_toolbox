****************************************************************************************
*** DRYVER - Hydrological modelling of the 6 European Drying River Networks (DRNs)
*** Flow intermittence indicators from the projection simulations in the Butiznica DRN (Croatia)
*** Contact : louise.mimeau@inrae.fr
****************************************************************************************

** Statistical flow intermittence indicators calculated from the simulated daily state of flow
* conD: Number of days per month/year with dry condition
* conF: Number of days per month/year with flowing condition
* durD: Number of consecutive days with dry conditions per month/year
* durF: Number of consecutive days with dry conditions per month/year
* FstDrE: Day of first drying event
* IntReg: Flow regime over a 30-year period (perennial or intermittent)
* numFreDr: Absolute number of drying events per month/year
* numFreRW: Absolute number of rewetting events per month/year
* PatchC: Patchiness per month/year: Proportion of model-derived reach length with changing flowing and intermittent conditions compared to adjacent downstream reaches
* RelFlow: Proportion of network length with perennial flow per month/year
* RelInt: Proportion of network length with intermittent flow per month/year

** Characteristics of the projection simulations:
* 3 SSP scenarios: SSP1-2.6, SSP3-7.0, SSP5-8.5
* Global Climate Models: gfdl-esm4, ipsl-cm6a-lr, mpi-esm1-2-hr, mri-esm2-0, ukesm1-0-ll
* The analogue downscaling method produced 20-members ensembles for each combination of GCMs and SSP scenarios for the 6 studied catchments. As the uncertainty related to the downscaling method is rather negligeable, only the 10th member at the center of the distribution is given in this dataset (see Mimeau et al. 2024).
* Reference period: 1985-2014 (data for the reference period are only given for SSP3-7.0)
* Projection period: 2015-2100
* JAMS-J2000 spatially distributed hydrological model: j2k_Krka
* Flow intermittence model: random_forest_Butiznica_2022-12-15_option0_8.RData

** Name of the ncdf files:
{1}_{2}_{3}_{4}_{5}_{6}_{7}_{8}.nc

{1}: name of the DRN
{2}: variable
{3}: projection (in distinction with the reconstruction simulations)
{4}: GCM
{5}: SSP
{6}: period of the dataset (reference period 1985-2014 or projection period 2015-2100)
{7}: spatial aggregation (distributed or aggregated)
{8}: time step (Monthly or Yearly)

** References: 
Mimeau, L., Künne, A., Branger, F., Kralisch, S., Devers, A., and Vidal, J.-P.: Flow intermittence prediction using a hybrid hydrological modelling approach: influence of observed intermittence data on the training of a random forest model, Hydrol. Earth Syst. Sci., https://doi.org/10.5194/hess-28-851-2024, 2024.

Mimeau, L., Künne, A., Devers, A., Branger, F., Kralisch, S., Lauvernet, C., Vidal, J.-P., Bonada, N., Csabai, Z., Mykrä, H., Pařil, P., Polović, L., and Datry, T.: Projections of streamflow intermittence under climate change in European drying river networks, Hydrol. Earth Syst. Sci., 29, 1615–1636, https://doi.org/10.5194/hess-29-1615-2025, 2025.
