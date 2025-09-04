SELECT
    U.username,
    P.content AS LIKED_POST
FROM 
    USER_ACCOUNT AS U
INNER JOIN POST_LIKE AS L
    ON U.id = L.user_id
INNER JOIN POST AS P
    ON L.post_id = P.id
WHERE U.id = 5;