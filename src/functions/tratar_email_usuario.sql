SET TERM ^ ;

CREATE OR ALTER FUNCTION tratar_email_usuario
 ( email VARCHAR(255) )
RETURNS VARCHAR(255)
AS
DECLARE email_minusculo VARCHAR(255);
DECLARE email_sem_espaco VARCHAR(255);
BEGIN
    email_minusculo = LOWER(email);
    email_sem_espaco = TRIM(email_minusculo);

    IF (email_sem_espaco NOT LIKE '%@%.%') THEN
        EXCEPTION EMAIL_INVALIDO_EXCEPTION;

    RETURN email_sem_espaco;
END^

SET TERM ; ^