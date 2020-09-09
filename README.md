# Prediction-of-box-office-profit-of-movies-using-hierarchical-clustering-random-forest-ensemble

# Masters in Data Analytics Project

## Project: Prediction of box-office profit of movies using hierarchical clustering random forest ensemble

## Table of Contents

- [Overview](#overview)
- [Components](#components)
  - [Data Extraction and Merging](#extraction)
  - [Data Visualizations](#visualization)
  - [Data Transformations and application of predictive model](#model)
- [Running the Code](#running)
- [Screenshots](#screenshots)
- [System Configuration steps](#config)
- [File Descriptions](#files)
- [Credits and Acknowledgements](#credits)

***

<a id='overview'></a>

### Overview
This research paper aims to predict the box office profit of a movie using a clustering and random forest based ensemble technique. The motivation behind this comes from the need of better predictive techniques in the movie industry owing to its unpredictable nature. The literature survey found meta data and social data to be important factors in predicting a movies box-office success. The use of clustering and random forest ensemble provided an accuracy of 78 percent on the training data and 62 percent on unseen or test data with a correlation of 78 percent between actual and predicted values. The variable importance chart showcased the budget, budget year ratio, release month, run time, genre, collection and review sentiment score to be influential in the profitability of a movie. The business use cases for this model and data considered is mainly for on-demand video service providers and television service companies.

<a id='components'></a>

### Components
There are three components to this project:

<a id='extraction'></a>

#### Data Extraction and Merging
File _'Visualization.py'_ :

- Extracts the `movie metadata` and `movie reviews` dataset.
- Performs sentiment analysis on movie reviews.
- Merges the two datasets to form the final dataset.
- Exports the merged data into a .csv file.

<a id='visualization'></a>

#### Data Visualizations
File _'Visualizations.pbix'_ :

- Imports the merged dataset.
- Create visulaizations using Microsoft PowerBI.
- Exports the visualizations into images.

<a id='model'></a>

#### Data Transformations and application of predictive model
File _'Prediction Model.r'_ :

- Imports the merged dataset.
- Applies Transformations on the data to gain information.
- Applies the predictive model on the data.
- Generates evaluation metrics

<a id='running'></a>

### Running the Code

The Data Extraction and Merging code in 'Visualization.py' has been created in Python and needs Python along with any IDE that supports Python codes in order to run the same.

The 'Visualizations.pbix' file contains visualizations created using PowerBI from th emerged dataset. This requires installation of PowerBI in order to open and view the visuals created.

The code in 'Prediction Model.r' needs to be opened on R Studio and can be run as a whole or run line by line. The code contains comments which provides details on what each chunk of code performs on the data.

The below sequence needs to be followed in order to run the whole code: 
- Visualization.py
- Visualizations.pbix (Optional, as it contains only visualizations)
- Prediction Model.r

<a id='screenshots'></a>

### Screenshots

<a id='config'></a>

### System Configuration Steps

In order to run the code, below are the necessary requirements:

- Python and Python IDE: As the code for data extraction and merging is written in Python, Python along with any IDE is required for the execution of the same. Below are the packages that are required as part of the pre-requisites for the same:

requests, json, pandas, numpy
- R and R Studio: As the code is developed in R, you need to install R as well as R Studio in order to open and execute the files.
- Packages: Below is a list of packages that need to be installed before execution of the code.

C50, caret, RWeka, pROC, psych, car, stringr, foreign
