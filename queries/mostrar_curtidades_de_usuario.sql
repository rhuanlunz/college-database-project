SELECT
    U.nome,
    P.conteudo AS POSTAGEM_CURTIDA
FROM 
    USUARIOS AS U
INNER JOIN CURTIDAS AS C
    ON U.id = C.id_usuario
INNER JOIN POSTAGENS AS P
    ON C.id_postagem = P.id
WHERE U.id = 5;