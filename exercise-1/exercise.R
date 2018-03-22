# Exercise 1: reading and querying a web API

# Load the httr and jsonlite libraries for accessing data
# You can also load `dplyr` if you wish to use it
library(httr)
library(jsonlite)
library(dplyr)

# Create a variable base_uri that stores the base URI (as a string) for the 
# Github API (https://api.github.com)
base_uri <- "https://api.github.com"

# Under the "Repositories" category of the API documentation, find the endpoint 
# that will list _repos in an organization_. Then create a variable named
# `org_resource` that stores the endpoint for the `programming-for-data-science`
# organization repos (this is the _path_ to the resource of interest).
org_resource <- "/orgs/programming-for-data-science/repos"

# Send a GET request to this endpoint (the `base_uri` followed by the 
# `org_resource` path). Print the response to show that your request worked. 
# (The listed URI will also allow you to inspect the JSON in the browser easily).
response <- GET(paste0(base_uri, org_resource))
print(response)

# Extract the content of the response using the `content()` function, saving it
# in a variable.
body <- content(response, "text")

# Convert the content variable from a JSON string into a data frame.
org_repos <- fromJSON(body)

# How many (public) repositories does the organization have?
print(nrow(org_repos))

# Now a second query:
# Create a variable `search_endpoint` that stores the endpoint used to search 
# for repositories. (Hint: look for a "Search" endpoint in the documentation).
search_endpoint <- '/search/repositories'

# Search queries require a query parameter (for what to search for). Create a 
# `query_params` list variable that specifies an appropriate key and value for 
# the search term (you can search for anything you want!)
query_params <- list(q = "visualization")

# Send a GET request to the `search_endpoint`--including your params list as the
# `query`. Print the response to show that your request worked.
response <- GET(paste0(base_uri, search_endpoint), query = query_params)
print(response)

# Extract the content of the response and convert it from a JSON string into a
# data frame. 
body <- content(response, "text")
results <- fromJSON(body)

# How many search repos did your search find? (Hint: check the list names to 
# find an appropriate value).
print(results$total_count)

# What are the full names of the top 5 repos in the search results?
vis_repo_names <- results$items$full_name[1:5]
print(vis_repo_names)
