SET TERM ^ ;

CREATE OR ALTER FUNCTION tratar_senha_usuario
    (senha VARCHAR(255))
RETURNS VARBINARY(64)
AS
BEGIN
    IF (CHAR_LENGTH(senha) < 8) THEN
        EXCEPTION SENHA_PEQUENA_EXCEPTION;
    
    RETURN crypt_hash(senha using sha256);
END^

SET TERM ; ^