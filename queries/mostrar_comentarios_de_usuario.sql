SELECT 
    U.nome,
    C.conteudo -- Conteúdo do comentário
FROM
    USUARIOS AS U
INNER JOIN COMENTARIOS AS C
    ON U.id = C.id_usuario -- Relaciona usuários aos seus comentários
ORDER BY C.data_criacao DESC; -- Ordena por data de criação (mais recentes primeiro)
