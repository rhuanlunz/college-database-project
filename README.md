## 💫 Projeto de Banco de Dados

Este é um projeto de banco de dados para a minha faculdade, desenvolvido usando Firebird SQL.

## 🙏 Membros do Grupo

* Davi
* Pedro
* Rhuan
* Ulisses

## Criando o Banco de Dados

Para criar o banco de dados, execute o script `setup.bat`.

No entanto, antes de executá-lo, você precisa atualizar a variável chamada `ISQL_EXECUTAVEL`, definindo-a como o caminho completo da ferramenta `isql.exe` do Firebird.

## 📕 Estrutura do Diretório

- `/migrations`: Scripts para criação, inserção e exclusão do banco de dados.
- `/migrations/seed`: Scripts para inserção de dados.
- `/queries`: Todas as consultas SQL.

## 🧱 Modelo de Banco de Dados

Eu uso [drawsql.app](https://drawsql.app) para modelar o banco de dados.

![Imagem do modelo de banco de dados](/images/db_model.png)