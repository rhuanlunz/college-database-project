SELECT
    U.nome,
    COUNT(P.id) AS TOTAL_DE_POSTAGENS -- Conta o total de postagens por usuário
FROM
    USUARIOS AS U
INNER JOIN POSTAGENS AS P
    ON U.id = P.id_usuario -- Relaciona usuários às suas postagens
GROUP BY U.nome;
