SET TERM ^ ;

CREATE OR ALTER FUNCTION tratar_email_usuario
 ( email VARCHAR(255) )
RETURNS VARCHAR(255)
AS
DECLARE email_minusculo VARCHAR(255);    -- Guardara o e-mail em minusculo
DECLARE email_sem_espaco VARCHAR(255);   -- Guardara o e-mail sem espacos
BEGIN
    -- Deixa tudo minúsculo
    email_minusculo = LOWER(email);
    -- Remove espaços no início e no fim
    email_sem_espaco = TRIM(email_minusculo);

    -- Verifica se tem o formato básico de e-mail (Via Regex)
    IF (email_sem_espaco NOT LIKE '%@%.%') THEN
        EXCEPTION EMAIL_INVALIDO_EXCEPTION;  

    -- Retorna o e-mail já tratado
    RETURN email_sem_espaco;
END^

SET TERM ; ^
