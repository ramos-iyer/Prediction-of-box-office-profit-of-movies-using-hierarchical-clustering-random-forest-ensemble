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

![Screenshot1](/images/data.png)

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

- PowerBI: The visualizations have been created in PowerBI and hence requires PowerBI.
- R and R Studio: As the code is developed in R, you need to install R as well as R Studio in order to open and execute the files. Below is a list of packages that need to be installed before execution of the code.

tidyverse, plotly, ggthemes, viridis, corrplot, gridExtra, VIM, lubridate, randomForest, caret, psych, RWeka, car, MLmetrics, cluster, clValid, StatMatch

<a id='files'></a>

### File Descriptions

Below are the files and the folders that are part of the project implementation:

1. Code:
- Visualization.py: Extracts the movie metadata and review data from the API and merges them to form the final dataset.
- Prediction Model.r: Imports the merged dataset and applies the predictive model on the same.

2. Visualization Dataset:
- TMDB Movie Reviews.xlsx: Contains the Movie reviews data
- TMDB Movies.xlsx: Contains the Movie metadata
- Visualizations.pbix: Contains the visualizations created in PowerBI

3. DAPA.json: Conatains the Movie metadata in .json format

4. DAPA_Reviews.json: Contains the Movie reviews data in .json format

5. TMDB Movies Full.csv: Contains the merged dataset used for model application

<a id='credits'></a>

### Credits and Acknowledgements

* [TMDB](https://www.themoviedb.org/) for providing the API to extract the data used for this project.
* [NCI](https://www.ncirl.ie/) for a challenging project as part of their full-time masters in data analytics course subject 'Domain Applications of Predictive Analytics'
