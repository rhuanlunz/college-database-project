@echo off
title Configurando Banco de Dados

:: ================================================================
::                     AREA DE CONFIGURACAO
:: ================================================================
set "ISQL_EXECUTAVEL=C:\Program Files\Firebird\Firebird_5_0\isql.exe"
set "DB_USER=SYSDBA"
set "DB_PASS=masterkey"

:: --- Fim da Configuracao ---

set "BASE_PATH=%~dp0"
set "DB_FILE=%BASE_PATH%database\RedeSocial.fdb"
set "SCRIPT_CREATE=%BASE_PATH%src\migrations\create.sql"
set "SEEDS_FOLDER=%BASE_PATH%src\migrations\seeds"
set "TRIGGERS_FOLDER=%BASE_PATH%src\triggers"
set "EXCEPTIONS_FOLDER=%BASE_PATH%src\exceptions"

echo.
echo === INICIANDO CONFIGURACAO DO BANCO DE DADOS ===
echo.

if not exist "%ISQL_EXECUTAVEL%" (
    echo !!!!! ERRO: 'isql.exe' nao encontrado em: !!!!!
    echo %ISQL_EXECUTAVEL%
    echo Por favor, edite o arquivo setup.bat e corrija o caminho.
    goto end
)

if not exist "%BASE_PATH%database\" mkdir "%BASE_PATH%database\"

echo [ETAPA 1/3] Criando arquivo de banco de dados...
echo CREATE DATABASE '%DB_FILE%'; > %BASE_PATH%temp_create.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%BASE_PATH%temp_create.sql"
if %errorlevel% neq 0 (
    echo !!!!! ERRO AO CRIAR O ARQUIVO .FDB !!!!!
    del "%BASE_PATH%temp_create.sql"
    goto end
)
del "%BASE_PATH%temp_create.sql"
echo Arquivo .FDB criado com sucesso!
echo.

echo [ETAPA 2/3] Criando tabelas e estrutura...
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%SCRIPT_CREATE%" "%DB_FILE%"
if %errorlevel% neq 0 (
    echo !!!!! ERRO AO EXECUTAR SCRIPT DE CRIACAO DE TABELAS !!!!!
    goto end
)
echo Tabelas criadas com sucesso!
echo.

echo    - Executando: seguidor_exception.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%EXCEPTIONS_FOLDER%\seguidor_exception.sql" "%DB_FILE%"

echo    - Executando: comentario_log_trigger.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%TRIGGERS_FOLDER%\comentario_log_trigger.sql" "%DB_FILE%"

echo    - Executando: configuracoes_usuarios_log_trigger.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%TRIGGERS_FOLDER%\configuracoes_usuarios_log_trigger.sql" "%DB_FILE%"

echo    - Executando: perfil_log_trigger.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%TRIGGERS_FOLDER%\perfil_log_trigger.sql" "%DB_FILE%"

echo    - Executando: post_log_trigger.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%TRIGGERS_FOLDER%\post_log_trigger.sql" "%DB_FILE%"

echo    - Executando: seguidor_trigger.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%TRIGGERS_FOLDER%\seguidor_trigger.sql" "%DB_FILE%"
echo .

:: ================================================================
::               SECAO DE SEEDS MODIFICADA
:: ================================================================
:: Agora executamos cada script NA ORDEM CORRETA
:: ================================================================

echo [ETAPA 3/3] Inserindo dados iniciais (seeds)...

REM --- PRIMEIRO, CRIAMOS OS DADOS MESTRE (USUARIOS) ---
echo    - Executando: usuarios.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%SEEDS_FOLDER%\usuarios.sql" "%DB_FILE%"

REM --- DEPOIS, OS DADOS QUE DEPENDEM DOS USUARIOS ---
echo    - Executando: configuracoes_usuario.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%SEEDS_FOLDER%\postagens.sql" "%DB_FILE%"
echo    - Executando: postagens.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%SEEDS_FOLDER%\postagens.sql" "%DB_FILE%"
echo    - Executando: seguidores.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%SEEDS_FOLDER%\seguidores.sql" "%DB_FILE%"

REM --- POR FIM, OS DADOS QUE DEPENDEM DE POSTS E USUARIOS ---
echo    - Executando: comentarios.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%SEEDS_FOLDER%\comentarios.sql" "%DB_FILE%"
echo    - Executando: curtidas.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%SEEDS_FOLDER%\curtidas.sql" "%DB_FILE%"

echo Dados inseridos com sucesso!
echo.

echo === PROCESSO CONCLUIDO! ===
echo O banco '%DB_FILE%' esta pronto para uso.
echo.

:end
pause
