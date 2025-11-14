SET TERM ^ ;

CREATE OR ALTER FUNCTION tratar_nome_usuario
 ( nome VARCHAR(255) )
RETURNS VARCHAR(255)
AS
DECLARE nome_minusculo VARCHAR(255);
DECLARE nome_sem_espacos VARCHAR(255);
BEGIN
    -- deixa tudo minúsculo para padronizar o nome
    nome_minusculo = LOWER(nome);
    -- tira espaços extras e troca espaço por underline (convenção do nosso banco)
    nome_sem_espacos = REPLACE(TRIM(nome_minusculo), ' ', '_');

    -- se o nome ficar muito curto depois do tratamentoo, caso contrario, exept.
    IF (CHAR_LENGTH(nome_sem_espacos) < 3) THEN
        EXCEPTION NOME_PEQUENO_EXCEPTION;

    -- só aceita letras e underline, caso contrario, except (Validação via REGEX)
    IF (nome_sem_espacos NOT SIMILAR TO '[A-Za-z_]+') THEN
        EXCEPTION CARACTERES_INVALIDOS_EXCEPTION;
        
    -- retorna o nome já tratado
    RETURN nome_sem_espacos;
END^

SET TERM ; ^
