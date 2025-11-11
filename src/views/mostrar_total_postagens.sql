CREATE OR ALTER VIEW MOSTRAR_TOTAL_POSTAGENS_VIEW AS
    SELECT
        U.nome,
        COUNT(P.id) AS TOTAL_DE_POSTAGENS -- Conta o total de postagens por usuario
    FROM
        USUARIOS AS U
    INNER JOIN POSTAGENS AS P
        ON U.id = P.id_usuario -- Relaciona usuarios as suas postagens
    GROUP BY U.nome;
