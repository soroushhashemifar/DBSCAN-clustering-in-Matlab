# DBSCAN-clustering-algorithm
Density-Based Spatial Clustering of Applications with Noise
#
All the details are included in the original article and this is implemented from the algorithm described in the original article. You can find the original article written by Martin Ester, Hans-Peter Kriegel, Jorg Sander and Xiaowei Xu here: `https://www.aaai.org/Papers/KDD/1996/KDD96-037.pdf`

You can run the algorithm by this pattern: `new_dataset = dbscan(dataset, epsilon, minPoints);`. input dataset is just a `n * 2` matrix but output dataset is a `n * 3` matrix such that the third column is the cluster IDs.

You can see the DBSCAN result below:
![dbscan_run](https://github.com/soroush76/DBSCAN-clustering-algorithm/blob/master/dbscan_run.jpg)

NOTE: Black points are noises.
