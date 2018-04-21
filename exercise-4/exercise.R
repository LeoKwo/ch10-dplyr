# Exercise 4: practicing with dplyr

# Install the `nycflights13` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
library(dplyr)
install.packages("nycflights13")
library(nycflights13)

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
View(flights)
nrow(flights)
ncol(flights)
colnames(flights)
?flights
dim(flights)

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
new_flights <- flights %>%
  mutate(time_gained = arr_delay - dep_delay)
View(new_flights)

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
new_flights <- new_flights %>%
                      arrange(time_gained)
new_flights

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame


# Make a histogram of the amount of time gained using the `hist()` function
hist(new_flights$time_gained)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
mean(new_flights$time_gained, na.rm = T)
summarize(new_flights, mean = mean(time_gained, na.rm = T))

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
jfk_sea <- new_flights %>% 
  filter(origin == "JFK", dest == "SEA") %>% 
  select(origin, dest, time_gained)
jfk_sea

# On average, did flights to SeaTac gain or loose time?


# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
summary <- new_flights %>% 
  filter(origin == "JFK", dest == "SEA") %>% 
  summarise(
    avg_time = mean(time_gained, na.rm = T),
    min_time = min(time_gained, na.rm = T),
    max_time = max(time_gained, na.rm = T)
  )
summary

