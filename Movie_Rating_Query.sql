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

/*
For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, 
return the reviewer's name and the title of the movie.
*/
SELECT DISTINCT name, title
FROM Movie, Reviewer, Rating, Rating R2
WHERE Movie.mID = Rating.mID AND Reviewer.rID = Rating.rID
AND Movie.mID = R2.mID AND R2.rID = Rating.rID
AND Rating.stars < R2.stars AND Rating.ratingDate < R2.ratingDate



/*
For each movie that has at least one rating, find the highest number of stars that movie received. 
Return the movie title and number of stars. Sort by movie title.
*/
SELECT DISTINCT title, MAX(stars)
FROM Movie JOIN Rating USING(mID)
GROUP BY title
ORDER BY title


/*
For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. 
Sort by rating spread from highest to lowest, then by movie title.
*/
SELECT title, (MAX(stars) - MIN(stars)) AS spread
FROM Rating JOIN Movie USING(mID)
GROUP BY mID
ORDER BY spread DESC, title


/*
Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. 
(Make sure to calculate the average rating for each movie, 
then the average of those averages for movies before 1980 and movies after. 
Don't just calculate the overall average rating before and after 1980.)
*/
SELECT (-AVG(after.avgafter80) + AVG(before.avgbefore80))
FROM
(
SELECT AVG(stars) as avgbefore80
FROM Rating JOIN Movie USING(mID)
WHERE year < 1980
GROUP BY title
) AS before
,
(
SELECT AVG(stars) as avgafter80
FROM Rating JOIN Movie USING(mID)
WHERE year > 1980
GROUP BY title
) AS after

