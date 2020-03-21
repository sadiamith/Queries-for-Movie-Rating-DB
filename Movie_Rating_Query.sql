/*
You've started a new movie-rating website, and you've been collecting data on reviewers' ratings of various movies. There's not much data yet, but you can still try out some interesting queries. Here's the schema:
Movie (mID, title, year, director)
English: There is a movie with ID number mID, a title, a release year, and a director.
Reviewer (rID, name)
English: The reviewer with ID number rID has a certain name.
Rating (rID, mID, stars, ratingDate)
English: The reviewer rID gave the movie mID a number of stars rating (1-5) on a certain ratingDate.
*/


/*
Find the titles of all movies directed by Steven Spielberg
*/
SELECT title 
FROM Movie 
WHERE director = 'Steven Spielberg';

/*
Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.
*/
SELECT DISTINCT year 
FROM Movie JOIN Rating 
WHERE Movie.mID = Rating.mID 
    AND Rating.stars >= 4
ORDER BY year



-- Find the titles of all movies that have no ratings.
SELECT title 
FROM Movie 
EXCEPT
SELECT DISTINCT title 
FROM Movie JOIN Rating
WHERE Movie.mID = Rating.mID


-- Some reviewers didn't provide a date with their rating. 
-- Find the names of all reviewers who have ratings with a NULL value for the date.
SELECT DISTINCT name 
FROM Reviewer, Rating 
WHERE Reviewer.rID = Rating.rID 
    AND Rating.ratingDate IS NULL


/*
Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. 
Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.
*/
SELECT DISTINCT name, title, stars, ratingDate 
FROM Movie, Reviewer, Rating
WHERE Movie.mID = Rating.mID AND Reviewer.rID = Rating.rID
ORDER BY name, title, stars


