@echo off
title Configurando Banco de Dados

:: ================================================================
::                     AREA DE CONFIGURACAO
:: ================================================================
set "ISQL_EXECUTAVEL=C:\Exata\Install\Firebird-4.0.2.2816-0-Win32\isql.exe"
set "DB_USER=SYSDBA"
set "DB_PASS=masterkey"

:: --- Fim da Configuracao ---

set "BASE_PATH=%~dp0"
set "DB_FILE=%BASE_PATH%database\college_project.fdb"
set "SCRIPT_CREATE=%BASE_PATH%migrations\create.sql"
set "SEEDS_FOLDER=%BASE_PATH%migrations\seeds"

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

:: ================================================================
::               SECAO DE SEEDS MODIFICADA
:: ================================================================
:: REMOVIDO O LOOP 'FOR'. AGORA EXECUTAMOS CADA SCRIPT NA ORDEM CORRETA.
:: ================================================================

echo [ETAPA 3/3] Inserindo dados iniciais (seeds)...

REM --- PRIMEIRO, CRIAMOS OS DADOS MESTRE (USUARIOS) ---
echo    - Executando: user_account.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%SEEDS_FOLDER%\user_account.sql" "%DB_FILE%"

REM --- DEPOIS, OS DADOS QUE DEPENDEM DOS USUARIOS ---
echo    - Executando: post.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%SEEDS_FOLDER%\post.sql" "%DB_FILE%"
echo    - Executando: user_follower.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%SEEDS_FOLDER%\user_follower.sql" "%DB_FILE%"
echo    - Executando: user_activity_log.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%SEEDS_FOLDER%\user_activity_log.sql" "%DB_FILE%"

REM --- POR FIM, OS DADOS QUE DEPENDEM DE POSTS E USUARIOS ---
echo    - Executando: post_comment.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%SEEDS_FOLDER%\post_comment.sql" "%DB_FILE%"
echo    - Executando: post_like.sql
"%ISQL_EXECUTAVEL%" -user %DB_USER% -pass %DB_PASS% -i "%SEEDS_FOLDER%\post_like.sql" "%DB_FILE%"

echo Dados inseridos com sucesso!
echo.

echo === PROCESSO CONCLUIDO! ===
echo O banco '%DB_FILE%' esta pronto para uso.
echo.

:end
pause