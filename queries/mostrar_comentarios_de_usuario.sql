SELECT 
    U.nome,
    C.conteudo
FROM
    USUARIOS AS U
INNER JOIN COMENTARIOS AS C
    ON U.id = C.id_usuario
WHERE U.id = 3
ORDER BY C.data_criacao DESC;