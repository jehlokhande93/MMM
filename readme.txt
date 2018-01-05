NOTE: Dataset cannot be shared publicly. However the structure of the data is described in the report PDF. 

There are 3 scripts that need to be run before generating insights. Once the initial 2 scripts have been run, further runs of only the third mentioned script (Model-PE-9855.rmd) need to be done

DataCleaning.py

This file needs to be run only when you have the original dataset with all the columns.
We have run this file and created the split datasets for each country-product combination.
You can use the split datasets to replicate the results if required directly.

EDA_DataSubsetting.r

This code runs the EDA on the initial dataset and does not need to be run every time you want
to train/use the model. It just helps you understand the reason for our appraoch in splitting the data

Model-PE-9855.rmd

This is the file that trains the actual model after all the data cleaning is done.
To run for other country-product combinations, just change the file name in the read_csv command. 
