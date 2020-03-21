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
