SET TERM ^ ;

CREATE OR ALTER FUNCTION tratar_senha_usuario
    (senha VARCHAR(255))
RETURNS VARBINARY(64)  -- tipo da criptografia que vai ser retornada.
AS
BEGIN
    -- verifica se a senha tem pelo menos 8 caracteres (conveção da nossa regra de negocio)
    IF (CHAR_LENGTH(senha) < 8) THEN
        EXCEPTION SENHA_PEQUENA_EXCEPTION;
    
    -- gera o hash da senha usando SHA-256 (não salva a senha real)
    RETURN crypt_hash(senha using sha256);
END^

SET TERM ; ^
