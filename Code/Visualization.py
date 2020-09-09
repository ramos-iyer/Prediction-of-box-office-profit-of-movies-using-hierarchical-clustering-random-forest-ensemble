# Importing required packages
import requests
# import pymongo as pm
# import pandas as pd
# import psycopg2 as pc2
# import pandas.io.sql as sqlio
# import numpy as np
# import plotly.graph_objects as go
# from plotly.offline import plot
# import plotly.io as pio
# pio.renderers.default = "svg"
import json

# Extracting the first 10000 popular movie IDs from TMDB API.
json_data = {}
movie_list = []
try:
    for a in range(1, 501):
        response = requests.get(
            "https://api.themoviedb.org/3/movie/popular?api_key=b7e7a7c29b9bf3b91508aa9599458b5a&language=en-US&page=" + str(
                a))
        if response.status_code == 200:
            json_data[a] = response.json()
        for b in range(0, 20):
            movie_list.append(json_data[a]["results"][b]["id"])
    print("Extracted popular movie IDs from the TMDB API.\n")
except (Exception, requests.RequestException) as connerr:
    print("Error while extracting data from the TMDB API\n", connerr)
finally:
    print("Proceeding to extract the full data of the movies...\n")

# Extracting all details for the 10000 popular movies on TMDB from API.
json_data = {}
try:
    for a in range(0, len(movie_list)):
        response = requests.get(
            "https://api.themoviedb.org/3/movie/" + str(movie_list[a]) + "?api_key=b7e7a7c29b9bf3b91508aa9599458b5a")
        if response.status_code == 200:
            json_data[a] = response.json()
    print("Extracted the full data of the movies from the TMDB API.\n")
except (Exception, requests.RequestException) as connerr:
    print("Error while extracting data from the TMDB API\n", connerr)
finally:
    print("Proceeding to input the full data of movies into a JSON file...\n")

# Exporting the movie data into a JSON file for project use.
json_file = 'E:/Study Material/Domain Applications of Predictive Analytics/Project/DAPA.json'

with open(json_file, 'w') as f:
    json.dump(json_data, f, sort_keys=True, indent=4)

print("Exported the full data of movies into a JSON file...\n")

# Extracting reviews for the 10000 popular movies on TMDB from API.
json_data_r = {}
try:
    for a in range(0, len(movie_list)):
        response = requests.get(
            "https://api.themoviedb.org/3/movie/" + str(movie_list[a]) + "/reviews?api_key=b7e7a7c29b9bf3b91508aa9599458b5a")
        if response.status_code == 200:
            json_data_r[a] = response.json()
    print("Extracted the full review data of the movies from the TMDB API.\n")
except (Exception, requests.RequestException) as connerr:
    print("Error while extracting data from the TMDB API\n", connerr)
finally:
    print("Proceeding to input the full review data of movie reviews into a JSON file...\n")

# Exporting the review data into a JSON file for project use.
json_file = 'E:/Study Material/Domain Applications of Predictive Analytics/Project/DAPA_reviews.json'

with open(json_file, 'w') as f:
    json.dump(json_data_r, f, sort_keys=True, indent=4)

print("Exported the full data of movie reviews into a JSON file...\n")

























