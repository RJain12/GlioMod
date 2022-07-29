# Info

GlioMod: Spatiotemporal-Aware Glioblastoma Multiforme Tumor Growth Modeling with Deep Encoder-Decoder Networks Rishab Kumar Jain

Under the direction of
Pierre F. J. Lermusiaux
Professor of Mechanical Engineering
Massachusetts Institute of Technology

Research Science Institute
August 1, 2022

# Code
The data preprocessing and mathematical modeling (synthetic tumor generation) for this project has been conducted in Python (.py). The neural modeling and encoder-decoder development has been done in MATLAB (.m).

## Math Modeling

First, the mathematical modeling must be performed. Due to the outrageous size of the data used for mathematical modeling (50+ GB), we have chosen to only make the processed, tabular (CSV) data publicly available. This tabular data is the processed data which we used to perform the neural modeling.

In order to perform the mathematical modeling, 6 patients had their brain scans taken, and CSF, GM, and WM segmentations were made. These NIFTI formatted segmentations and scan were converted to .DAT - the format that the mathematical solver required (math solver was used as the ground-truth).

The preprocessData.m script in math_modeling/ is what helps format some of these NIFTI files for conversion to DAT files. The mathematical solver utilized in this research is Lipkova et al.'s GliomaSolver. This solver has in-house scripts for making the NIFTI to DAT conversion in MATLAB.

After this point, the input patients with CSF, GM, WM segmentations made in the DAT format are fed into createTrainingData.py. This script inferences the GliomaSolver tool, and its brain/brain256/engine executables. This script is also dependent on slice.nii -- a boundary mask that we have created to help define synthetic tumor starting points.

## Processing

Then, the preprocessing scripts are ran. vtu2csv.py is the script that goes through the processed data (now dumped in VTU format at 50 day intervals for tumor simulation). It utilizes the meshio library to convert these into tabular CSV data via numpy. These CSVs can be imported/visualized in MATLAB in a similar way demonstrated in the visualizeCSV.m file.

## Neural Modeling
Now, the dayStruct object is set up with setupDayStruct.m. This loads in the patient CSV files into a large cell array. Then, the createCNNTrainingData.m script is utilized to traverse the dayStruct cell array and create cubic images stored in XTrain,YTrain,XTest,YTest 4-dimensional double arrays in x,y,z,n format [x,y,z image --> n number (100 used in simulation)]. The script also combines this data into a combinedDatastore of arrayDatastores.

This data is fed into the trainEncoderDecoder.m file. The encoder decoder network is trained with the similar hyper parameters. For more details on our optimization and specific hyper parameters that were tested, read our paper.

This network was trained on a high performance compute cluster at MSEAS of MIT with 10x NVIDIA RTX a6000.

# Paper
At this time, the detailed paper with full methodological descriptions is not public. Star this repo and check back later!