SELECT 
    U.username,
    C.content
FROM
    USER_ACCOUNT AS U
INNER JOIN POST_COMMENT AS C
    ON U.id = C.user_id
WHERE U.id = 3
ORDER BY C.created_at DESC;