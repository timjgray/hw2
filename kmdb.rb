# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!

# Rubric
# 
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)

# Submission
# 
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the 
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======

# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========

# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
Movie.destroy_all
Studio.destroy_all
Actor.destroy_all
Role.destroy_all

# Generate models and tables, according to the domain model.
# DONE

# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.

new_studio = Studio.new 
new_studio["name"] = "Warner Bros."
new_studio.save

wb_studio = Studio.find_by({ "name" => "Warner Bros." })

movie1 = Movie.new
movie1["title"] = "Batman Begins"
movie1["year released"] = 2005
movie1["rated"] = "PG-13"
movie1["studio_id"] = wb_studio["id"]
movie1.save

movie2 = Movie.new
movie2["title"] = "The Dark Knight"
movie2["year released"] = 2008
movie2["rated"] = "PG-13"
movie2["studio_id"] = wb_studio["id"]
movie2.save

movie3 = Movie.new
movie3["title"] = "The Dark Knight Rises"
movie3["year released"] = 2012
movie3["rated"] = "PG-13"
movie3["studio_id"] = wb_studio["id"]
movie3.save


BB_actor_names = ["Christian Bale", "Michael Caine", "Liam Neeson", "Katie Holmes", "Gary Oldman"]

DK_actor_names = ["Christian Bale", "Heath Ledger","Aaron Eckhart", "Michael Caine", 
"Maggie Gyllenhaal"]

DKR_actor_names = ["Christian Bale", "Gary Oldman", "Tom Hardy", "Joseph Gordon-Levitt", "Anne Hathaway"]


for name in BB_actor_names 
    actor = Actor.new 
    actor.name = name
    actor.movie_id = BB_id
    actor.save
end

BB_characters = [
"Bruce Wayne",
"Alfred",
"Ra's Al Ghul",
"Rachel Dawes",
"Commissioner Gordon"]

DK_characters =[ 
"Bruce Wayne", 
"Joker",
"Harvey Dent",
"Alfred"] 

DKR_characters = [
"Bruce Wayne",
"Comissioner Gordon", 
"Bane",
"John Blake",
"Selina Kyle"]

BB_id = Movie.find_by({ "title" => "Batman Begins" })
DK_id = Movie.find_by({ "title" => "The Dark Knight" })
DKR_id = Movie.find_by({ "title" => "The Dark Knight Rises"})

for person in BB_characters
    role = Role.new 
    role.character_name = person
    role.movie_id = BB_id["id"]
    role.save
end

for person in DK_characters
    role = Role.new 
    role.character_name = person
    role.movie_id = DK_id["id"]
    role.save
end

for person in DKR_characters
    role = Role.new 
    role.character_name = person
    role.movie_id = DKR_id["id"]
    role.save
end

for person in DK_characters
    role = Role.new 
    role.character_name = person
    role.movie_id = DK_id["id"]
    role.save
end

for person in DKR_characters
    role = Role.new 
    role.character_name = person
    role.movie_id = DKR_id["id"]
    role.save
end

all_actors = Actor.all
all_movies = Movie.all
all_roles = Role.all

# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""

# Query the movies data and loop through the results to display the movies output.
for movie in all_movies
    title = movie["title"]
    year = movie["year released"]
    rating = movie["rated"]
    studio = "Warner Bros."
    puts "#{title} #{year} #{rating} #{studio}"
    #print movie["title"], " " , movie["year released"], " ", movie["rated"], " ", movie["studio_id"]
  end

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
for actor in all_actors
    name = actor["name"]
    puts "#{name}"
  end

for role in all_roles
    name = role["character_name"]
    movie = ((Movie.where({"id" => role["movie_id"]})).inspect)[title]
    puts "#{name} #{movie}"
end
