# Importing packages
library(tidyverse)
library(plotly)
library(ggthemes)
library(viridis)
library(corrplot)
library(gridExtra)
library(VIM)
library(lubridate)
library(randomForest)
library(caret)
library(psych)
library(RWeka)
library(car)
library(MLmetrics)
library(cluster)
library(clValid)
library(StatMatch)

# importing csv data
full_data = read.csv('E:/Study Material/Domain Applications of Predictive Analytics/Project/TMDB Movies Full.csv', na.strings=c("", '#N/A', '[]', '0'))

#glimpse of full data
glimpse(full_data)

#extracting collection names
full_data$coll_name <- str_extract(full_data$coll_name, 
                                         pattern = "(?<=name\\'\\:\\s{1}\\').+(?=\\'\\,\\s{1}\\'poster)")
# checking biggest collections
full_data %>%
  group_by(coll_name) %>%
  summarise(movie_count = n()) %>%
  arrange(desc(movie_count)) %>%
  filter(!is.na(coll_name)) %>%
  head(10) 

# creating collection or no collection 
full_data$collection[!is.na(full_data$coll_name)] <- 'Collection'
full_data$collection[is.na(full_data$coll_name)] <- 'No collection'

#creating main genre column
genres_matching_point <- "Comedy|Horror|Action|Drama|Documentary|Science Fiction|
              Crime|Fantasy|Thriller|Animation|Adventure|Mystery|War|Romance|Music|
              Family|Western|History|TV Movie|Foreign"

full_data$main_genre <- str_extract(full_data$genre_name, genres_matching_point)

# production companies extraction
full_data$prod_comp_id <- str_extract(full_data$prod_cmpny, 
                                      pattern = "([0-9]+)")
full_data$prod_comp_id <- as.numeric(full_data$prod_comp_id)

# correlation check
cor(full_data$profit, full_data$prod_comp_id, use = 'complete.obs')

#prod companies
full_data %>%
  group_by(prod_comp_name) %>%
  summarise(movie_count = n()) %>%
  arrange(desc(movie_count)) %>%
  filter(!is.na(prod_comp_name)) %>%
  head(10)

full_data$top_prod_comp[full_data$prod_comp_name=='Paramount'] <- 'Paramount'
full_data$top_prod_comp[full_data$prod_comp_name=='Universal Pictures'] <- 'Universal Pictures'
full_data$top_prod_comp[full_data$prod_comp_name=='Columbia Pictures'] <- 'Columbia Pictures'
full_data$top_prod_comp[full_data$prod_comp_name=='Warner Bros. Pictures'] <- 'Warner Bros. Pictures'
full_data$top_prod_comp[full_data$prod_comp_name=='20th Century Fox'] <- '20th Century Fox'
full_data$top_prod_comp[full_data$prod_comp_name=='New Line Cinema'] <- 'New Line Cinema'

full_data$top_prod_comp[is.na(full_data$top_prod_comp)] <- 'Other'

full_data$prod_comp_size[full_data$prod_comp_name=='Universal Pictures'] <- 'Big producer' 
full_data$prod_comp_size[full_data$prod_comp_name=='Paramount'] <- 'Big producer' 
full_data$prod_comp_size[full_data$prod_comp_name=='20th Century Fox'] <- 'Big producer'
full_data$prod_comp_size[full_data$prod_comp_name=='Columbia Pictures'] <- 'Big producer'
full_data$prod_comp_size[full_data$prod_comp_name=='New Line Cinema'] <- 'Big producer'
full_data$prod_comp_size[full_data$prod_comp_name=='Warner Bros. Pictures'] <- 'Big producer'

full_data$prod_comp_size[is.na(full_data$prod_comp_size)] <- 'Small producer'

# production countries
full_data$prod_cntry_name <- str_extract(string = full_data$prod_cntry, 
                                      pattern = "[:upper:]+")

full_data %>%
  group_by(prod_cntry_name) %>%
  summarise(movie_count = n()) %>%
  arrange(desc(movie_count)) %>%
  filter(!is.na(prod_cntry_name)) %>%
  head(10) 

full_data$top_prod_country[full_data$prod_cntry_name=='US'] <- 'United States'
full_data$top_prod_country[full_data$prod_cntry_name=='GB'] <- 'Great Britain'
full_data$top_prod_country[full_data$prod_cntry_name=='CA'] <- 'Canada'
full_data$top_prod_country[full_data$prod_cntry_name=='FR'] <- 'France'
full_data$top_prod_country[full_data$prod_cntry_name=='DE'] <- 'Denmark'

full_data$top_prod_country[is.na(full_data$top_prod_country)] <- 'Other'

# imdb_id
full_data$imdb_id <- str_extract(full_data$imdb_id, '[0-9]+')
full_data$imdb_id <- as.numeric(full_data$imdb_id)
cor(full_data$profit, full_data$imdb_id, use = 'complete.obs')

# languages
full_data %>%
  group_by(og_language) %>%
  summarise(movie_count = n()) %>%
  arrange(desc(movie_count)) %>%
  filter(!is.na(og_language)) %>%
  head(10) 
full_data$og_language <- as.character(full_data$og_language)
full_data$lang_name[full_data$og_language=='en'] <- 'English'
full_data$lang_name[is.na(full_data$lang_name)] <- 'Non-English'

# release_date
which(is.na(full_data$release_date))

full_data$release_date <- as.character(full_data$release_date)
full_data$release_date_mod <- parse_date_time2(full_data$release_date, "Ymd",
                                               cutoff_2000 = 20)

full_data$year_released <- ymd(full_data$release_date_mod) %>% 
  lubridate::year()  # Grab year.

full_data$quarter_released <- ymd(full_data$release_date_mod) %>%
  lubridate::quarter()  # Grab quarter.

full_data$month_released <- ymd(full_data$release_date_mod) %>% 
  lubridate::month(label = TRUE, abbr = FALSE)  # Grab month.

full_data$week_released <- ymd(full_data$release_date_mod) %>%
  lubridate::week()  # Grab week.

full_data$weekday_released <- ymd(full_data$release_date_mod) %>%
  lubridate::wday(label = TRUE, abbr = FALSE)  # Grab weekday.

#tagline
full_data$tagline_presence[is.na(full_data$tagline)] <- 'No tagline'
full_data$tagline_presence[is.na(full_data$tagline_presence)] <- 'Tagline'

#homepage
full_data$homepage_presence[is.na(full_data$homepage)] <- 'No homepage'
full_data$homepage_presence[is.na(full_data$homepage_presence)] <- 'Homepage'

#numbers
full_data$number_of_genres <- str_count(full_data$genre_name, 'name')
full_data$number_of_prod_companies <- str_count(full_data$prod_cmpny, 'name')
full_data$number_of_prod_countries <- str_count(full_data$prod_cntry, 'name')
full_data$number_of_spoken_languages <- str_count(full_data$languages, 'name')

#length
full_data$title_length <- as.numeric(str_length(full_data$title))
full_data$tagline_length <- as.numeric(str_length(full_data$tagline))
full_data$overview_length <- as.numeric(str_length(full_data$overview))

cor(full_data$profit, full_data$title_length, use = 'complete.obs')
cor(full_data$profit, full_data$tagline_length, use = 'complete.obs')
cor(full_data$profit, full_data$overview_length, use = 'complete.obs')

#creating final dataset
full_data_subset <- subset(full_data, 
                           select = c(popularity, runtime, budget, prod_comp_size, 
                                      top_prod_comp, main_genre, lang_name, collection,
                                      top_prod_country, tagline_presence, homepage_presence,
                                      year_released, quarter_released, month_released, week_released,
                                      weekday_released, number_of_prod_companies,
                                      number_of_genres, title_length, tagline_length, 
                                      review_sentiment_score, review_sentiment_category,
                                      profit))

#missing value analysis
aggr(full_data_subset, sortVars = TRUE, prop = FALSE, only.miss = TRUE, cex.axis = .35, 
     numbers = TRUE, col = c('grey99','red'))

#dealing with missing values
full_data_subset$tagline_length[is.na(full_data_subset$tagline_length)] <- mean(full_data_subset$tagline_length, na.rm = TRUE)
full_data_subset$number_of_prod_companies[is.na(full_data_subset$number_of_prod_companies)] <- 1
full_data_subset$main_genre[is.na(full_data_subset$main_genre)] <- "Drama"
full_data_subset$tagline_length[is.na(full_data_subset$tagline_length)] <- mean(full_data_subset$tagline_length, na.rm = TRUE)

which(is.na(full_data$profit))

full_data_subset <- full_data_subset[-c(3721), ]

#budget year ratio
full_data_subset$budget_year_ratio <- full_data_subset$budget/full_data_subset$year_released

#final touches
full_data_subset <- full_data_subset %>% mutate_if(is.character, as.factor)
full_data_subset$weekday_released <- factor(full_data_subset$weekday_release, ordered = FALSE)
full_data_subset$month_released <- factor(full_data_subset$month_released, ordered = FALSE)
full_data_subset$quarter_released <- factor(full_data_subset$quarter_released)

# creating training and testing data sets
set.seed(5)
train_sample <- sample(nrow(full_data_subset), round(0.8*nrow(full_data_subset)))

train <- full_data_subset[train_sample, ]
test <- full_data_subset[-train_sample, ]
summary(train$profit)
summary(test$profit)
train_x <- train[,-23]
train_y <- train[,23]

#applying clustering
dist_val <- daisy(train, metric = "gower")
hc.train <- hclust(dist_val, method = "ward.D")
summary(hc.train)
plot(hc.train)
cl_index <- cutree(hc.train, k=2)

train=(train)[hc.train$order,]

train1 <- train[cl_index == 1,]
train2 <- train[cl_index == 2,]

#splitting x and y for best mtry rf
train1_x <- train1[,-23]
train1_y <- train1[,23]
train2_x <- train2[,-23]
train2_y <- train2[,23]

#applying random forest
set.seed(123)

bestmtry1 <- tuneRF(train1_x, train1_y, ntree=1000, doBest = TRUE, nodesize = 5, importance = TRUE, replace = TRUE)
bestmtry2 <- tuneRF(train2_x, train2_y, ntree=1000, doBest = TRUE, nodesize = 5, importance = TRUE, replace = TRUE)
bestmtryf <- randomForest(x=train_x, y=train_y, ntree=2, mtry = 23, nodesize = 8, importance = TRUE)

rf_model <- combine(bestmtry1, bestmtry2)
print(rf_model)
print(bestmtryf)

plot(bestmtryf)
plot(bestmtry2)

importance <- importance(rf_model)

# Create data frame using importance. 
varImportance <- data.frame(Variables = row.names(importance), 
                            Importance = round(importance[,'IncNodePurity'], 0))

# Create interactive plot.  
ggplotly(ggplot(varImportance, aes(x = reorder(Variables, Importance), 
                                   y = Importance, fill = Importance)) +
           geom_bar(stat='identity') + 
           labs(title = 'Importance of predictors', x = 'Predictors', y = 'rmsle') +
           coord_flip() + 
           theme_light())

# calculating R2 of the trained model
actual_train <- train$profit
predicted_train <- unname(predict(rf_model, train[,-23]))
actual_test <- test$profit
predicted_test <- unname(predict(rf_model, test[,-23]))
predicted_train_full <- unname(predict(bestmtryf, train[,-23]))
predicted_test_full <- unname(predict(bestmtryf, test[,-23]))

#R2 of the models
R2_train <- R2_Score(predicted_train, actual_train)
R2_test <- R2_Score(predicted_test, actual_test)
R2_train_full <- R2_Score(predicted_train_full, actual_train)
R2_test_full <- R2_Score(predicted_test_full, actual_test)
cat("The R2 of the clustered model on training data is ", R2_train,
    "\nThe R2 of the clustered model on test data is ", R2_test,
    "\nThe R2 of the full model on training data is ", R2_train_full,
    "\nThe R2 of the full model on test data is ", R2_test_full)

#correlations of the models
cor_train <- cor(actual_train, predicted_train)
cor_test <- cor(actual_test, predicted_test)
cor_train_full <- cor(actual_train, predicted_train_full)
cor_test_full <- cor(actual_test, predicted_test_full)
cat("The correlation of the clustered model on training data is ", cor_train,
    "\nThe correlation of the clustered model on test data is ", cor_test,
    "\nThe correlation of the full model on training data is ", cor_train_full,
    "\nThe correlation of the full model on test data is ", cor_test_full)

#Mean absolute error
mae_train <- MAE(actual_train, predicted_train)
mae_test <- MAE(actual_test, predicted_test)
mae_train_full <- MAE(actual_train, predicted_train_full)
mae_test_full <- MAE(actual_test, predicted_test_full)
cat("The mean absolute error of the clustered model on training data is ", mae_train,
    "\nThe mean absolute error of the clustered model on test data is ", mae_test,
    "\nThe mean absolute error of the full model on training data is ", mae_train_full,
    "\nThe mean absolute error of the full model on test data is ", mae_test_full)

#Root mean squared error loss
rmse_train <- RMSE(actual_train, predicted_train)
rmse_test <- RMSE(actual_test, predicted_test)
rmse_train_full <- RMSE(actual_train, predicted_train_full)
rmse_test_full <- RMSE(actual_test, predicted_test_full)
cat("The root mean sq. error loss of the clustered model on training data is ", rmse_train,
    "\nThe The root mean sq. error loss of the clustered model on test data is ", rmse_test,
    "\nThe The root mean sq. error loss of the full model on training data is ", rmse_train_full,
    "\nThe The root mean sq. error loss of the full model on test data is ", rmse_test_full)

