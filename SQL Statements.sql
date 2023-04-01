USE BUDT703_Project_0506_08

SELECT TOP 5 s.sngName AS 'Song', s.sngPlayCount AS 'Times Played'
FROM [Spotify.Song] s
ORDER BY s.sngPlayCount DESC

SELECT t2.artName, t2.sngLike,t2.gnrName
FROM(
	SELECT Row_Number() OVER ( PARTITION BY t1.gnrName order by t1.sngLike DESC) 
AS row_number, *
	FROM(
SELECT a.artName, s.sngLike, g.gnrName
		FROM [Spotify.Artist] a, [Spotify.Release] r, [Spotify.Song] s, 
[Spotify.Classify] c,[Spotify.Genre] g
		WHERE a.artId = r.artId AND r.sngId = s.sngId AND s.sngId = c.sngId AND c.gnrId = g.gnrId)
t1) 
t2
WHERE t2.row_number = 1

SELECT g.gnrName AS 'Genre Name',COUNT(s.sngId) AS 'Number of songs'
FROM [Spotify.Classify] c,[Spotify.Song] s,[Spotify.Genre] g
WHERE g.gnrId = c.gnrId AND s.sngId = c.sngId
GROUP BY g.gnrName
ORDER BY COUNT(s.sngId) DESC

SELECT a.artName AS 'Artist Name',SUM(s.sngLike) AS 'Number of total likes'
FROM [Spotify.Artist] a, [Spotify.Release] r,[Spotify.Song] s
WHERE a.artId = r.artId AND r.sngId = s.sngId
GROUP BY a.artName
ORDER BY SUM(s.sngLike) DESC
