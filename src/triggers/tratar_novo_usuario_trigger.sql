SET TERM ^ ;

CREATE OR ALTER TRIGGER tratar_novo_usuario_trigger
    ACTIVE
    BEFORE INSERT
    POSITION 0
        ON USUARIOS
AS
BEGIN
    NEW.NOME = tratar_nome_usuario(NEW.NOME);               -- chama funcões e passa como argumento o necessario
    NEW.EMAIL = tratar_email_usuario(NEW.EMAIL);            -- chama funcões e passa como argumento o necessario
    NEW.HASH_SENHA = tratar_senha_usuario(NEW.HASH_SENHA);  -- chama funcões e passa como argumento o necessario
END^

SET TERM ; ^
