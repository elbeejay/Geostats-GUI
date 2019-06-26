# Geostats-GUI
GUI to compute 2-D variogram and entrogram; geostatistical measures of spatial correlation and spatial disorder scales.

<img src="https://github.com/elbeejay/Geostats-GUI/blob/master/example.PNG" width="500">

------------------------------------------------------------------------------------------------------------------------------------------
## Background

The variogram is a standard method used to analyze spatial data. Some sources for information about how the variogram is computed and analyzed are the following:

- Pyrcz, M.J., and Deutsch, C.V., 2014, Geostatistical Reservoir Modeling, 2nd Edition, Oxford University Press, New York, p. 448

- Kitanidis, P. (1997). Introduction to Geostatistics: Applications in Hydrogeology. Cambridge: Cambridge University Press. https://doi.org/10.1017/CBO9780511626166

The entrogram is a new metric that has been proposed as a complemetary method for analyzing spatial data through the analysis of Shannon Entropy at different spatial scales. It was originally introduced and proposed in the following literature:

- Bianchi, M., & Pedretti, D. (2018). An entrogram-based approach to describe spatial heterogeneity with applications to solute transport in porous media. Water Resources Research. https://doi.org/10.1029/2018WR022827

- Bianchi, M., & Pedretti, D. (2017). Geological entropy and solute transport in heterogeneous porous media. Water Resources Research, 53(6), 4691–4708. https://doi.org/10.1002/2016WR020195

------------------------------------------------------------------------------------------------------------------------------------------
## Instructions for Use

1. Clone and unzip the repository to your local machine
2. Open MATLAB and navigate to the 'Geostats-GUI-master' folder (set as the working directory/'Current Folder') and open the geostatsGUI.mlapp file
3. From there you can use the GUI to load 2-D arrays and visualize their variograms and entrograms in 1-D and 2-D

Input file:
              Must be a .mat file containg a 2-D array named "field" that is going to be analyzed.
      
Plot button visualizes the array in the top figure.

Parameters:
              
- X cell dim. (m/cell): specifies the dimension of each cell in the x-direction in meters (units can really be anything)
- Y cell dim. (m/cell): specifies the dimension in the y-direction for each cell
              
- &#35; pts. X: identifies the number of points to be used for the variogram calculation in the x-direction; for large fields      using every data point creates excessively high computational times.
- &#35; pts. Y: identifies the number of points to be used for the variogram calculation in the y-direction; for large fields      using every data point creates excessively high computational times.
              
- Distances in X Only: restricts the computation of the variogram to distances in the x-dimension only (1-D variogram), can be used when there are large scale disparities or there is an interest in looking at directionality of the spatial variance in the field. 
- Distances in Y Only: restrictes the computation of the variogram to distances in the y-dimension only (1-D variogram).                 
- Y-Scale Factor: specifies a number of cells in the y-dimension to expand the moving window for each single cell expansino of the window in the x-direction. Can be used to ensure that the same proportion of the field is being assessed in each dimension as the window size expands. 
- X-Scale Factor: provides the same function but in the x-dimension which would be used if there are more cells in the x-direction than the y.
- Increase window in X only: is intended to limit the window expansion to the x-direction only (1-D entrogram).
- Increase window in Y only: is intended to limit the window expansion to the y-direction only (1-D entrogram).

#### Note (6/26/2019):
Currently, if a computation is tried and an error is returned, the working directory (as indicated in the 'Current Folder' panel) needs to be manually reset to the 'Geostats-GUI-master' folder or the buttons and GUI functionality will not work.
              
----------------------------------------------------------------------------------------------------------------------------------------

2 test cases are included to try GUI functionality and see how these statistics work
- test.mat contains a more variable field which will have a shorter correlation length in the variogram and in the entrogram the window size at which the local and global entropies are equivalent will be smaller
- test2.mat in comparison is a less variable field and will take longer to reach the 'sill' in both the variogram and entrogram cases
              
              
