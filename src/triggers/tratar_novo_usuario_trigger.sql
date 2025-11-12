SET TERM ^ ;

CREATE OR ALTER TRIGGER tratar_novo_usuario_trigger
    ACTIVE
    BEFORE INSERT
    POSITION 0
        ON USUARIOS
AS
BEGIN
    NEW.NOME = tratar_nome_usuario(NEW.NOME);
    NEW.EMAIL = tratar_email_usuario(NEW.EMAIL);
    NEW.HASH_SENHA = tratar_senha_usuario(NEW.HASH_SENHA);
END^

SET TERM ; ^


