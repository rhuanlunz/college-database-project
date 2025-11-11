SELECT
    U.nome,
    P.conteudo AS POSTAGEM_CURTIDA -- Conteúdo da postagem que foi curtida
FROM 
    USUARIOS AS U
INNER JOIN CURTIDAS AS C
    ON U.id = C.id_usuario -- Relaciona usuários às curtidas que fizeram
INNER JOIN POSTAGENS AS P
    ON C.id_postagem = P.id -- Relaciona curtidas às postagens curtidas
WHERE U.id = 5; -- Filtra para exibir apenas o usuário com ID 5
