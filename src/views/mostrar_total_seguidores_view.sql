CREATE OR ALTER VIEW MOSTRAR_TOTAL_SEGUIDORES_VIEW(NOME_USUARIO, TOTAL_DE_SEGUIDORES) AS
    SELECT
        U1.nome AS NOME_USUARIO,
        COUNT(U2.nome) AS TOTAL_DE_SEGUIDORES -- Conta quantos seguidores cada usuario tem
    FROM
        SEGUIDORES AS S
    INNER JOIN USUARIOS AS U1 -- Usuario que esta sendo seguido
        ON S.id_usuario = U1.id -- Relaciona o seguido ao seu ID
    INNER JOIN USUARIOS AS U2 -- Usuario que segue
        ON S.id_seguidor = U2.id -- Relaciona o seguidor ao seu ID
    GROUP BY U1.nome
    ORDER BY TOTAL_DE_SEGUIDORES DESC; -- Ordena do mais seguido para o menos seguido