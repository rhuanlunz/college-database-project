CREATE OR ALTER VIEW MOSTRAR_COMENTARIOS_VIEW AS
    SELECT 
        U.nome,
        C.conteudo -- Conteudo do comentario
    FROM
        USUARIOS AS U
    INNER JOIN COMENTARIOS AS C
        ON U.id = C.id_usuario -- Relaciona usuarios aos seus comentarios
    ORDER BY C.data_criacao DESC; -- Ordena por data de criaçao (mais recentes primeiro)
