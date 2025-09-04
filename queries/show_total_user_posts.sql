SELECT
    U.username,
	COUNT(P.id) AS TOTAL_POSTS
FROM
    USER_ACCOUNT AS U
INNER JOIN POST AS P
    ON U.id = P.user_id
GROUP BY U.username;