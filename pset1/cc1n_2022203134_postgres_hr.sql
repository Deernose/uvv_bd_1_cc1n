\c postgres
\! echo 'RESETANDO DATABASE PARA AS CONFIGURAÇOES PADROES'
DROP DATABASE IF EXISTS uvv;
DROP USER IF EXISTS 'deernose'@'localhost';
\! echo '...'
----------------------------------------------------------------------------------
-- CRIAR A DATABASE DA UVV COM O NOME SOLICITADO PELO PROFESSOR
----------------------------------------------------------------------------------
CREATE DATABASE uvv;
GRANT ALL PRIVILEGES ON *.* TO 'deernose'@'%' IDENTIFIED BY '1234';
----------------------------------------------------------------------------------
--
--
--
--                      SENHA: 1234
--
--
--
----------------------------------------------------------------------------------
-- \c uvv deernose;
\c uvv;
----------------------------------------------------------------------------------
-- INSERIR TODAS TABELAS
----------------------------------------------------------------------------------
