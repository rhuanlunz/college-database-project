SET TERM ^ ;

CREATE OR ALTER FUNCTION tratar_nome_usuario
 ( nome VARCHAR(255) )
RETURNS VARCHAR(255)
AS
DECLARE nome_minusculo VARCHAR(255);
DECLARE nome_sem_espacos VARCHAR(255);
BEGIN
    nome_minusculo = LOWER(nome);
    nome_sem_espacos = REPLACE(TRIM(nome_minusculo), ' ', '_');

    IF (CHAR_LENGTH(nome_sem_espacos) < 3) THEN
        EXCEPTION NOME_PEQUENO_EXCEPTION;

    IF (nome_sem_espacos NOT SIMILAR TO '[A-Za-z_]+') THEN
        EXCEPTION CARACTERES_INVALIDOS_EXCEPTION;
        
    RETURN nome_sem_espacos;
END^

SET TERM ; ^ 