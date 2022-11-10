Projeto PSET 1 - CC1N
================================

### Vitor Deernose - Prof. Abrantes Filho

Observação
--------------------------------
Abaixo apresento o projeto original (com marcaçoes para identificação visual) que o Abrantes disponibilizou para o PSET 1
analisando 
![hr](https://user-images.githubusercontent.com/32472199/201040044-15b6f8e9-62f4-4b8e-9b95-9661e18a8c96.png)

Construção
--------------------------------
#### Para construir o banco de dados utilizei o Power Architect

![image](https://user-images.githubusercontent.com/32472199/201028335-01a5da38-c5e9-40a6-be4d-777f158a8863.png)

Primeiro fiz o teste colocando todo script do Power architect depois inserindo as informaçoes, 
porem ao chegar a tabela 'empregados' e 'departamentos' encontrei um loop onde não pude prosseguir, por conta disso eu separei as CONSTRAINT'S de relação dessa etapa e a coloquei no fim do script.

Comandos ORACLE SQL 'HR'
--------------------------------
#### REGIOES:
>SELECT 'INSERT INTO regioes (id_regiao, nome) VALUES ('
>  || region_id || ', ''' || region_name || ''');'
>from regions;

#### PAISES
>SELECT 'INSERT INTO paises (id_pais, id_regiao, nome) VALUES (''' || country_id || ''', ' || region_id || ', ''' || country_name || ''');'
>from countries;

#### LOCALIZACOES
>SELECT 'INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES ('
>  || location_id || 
>  ', ''' || street_address || 
>  ''', ''' || postal_code || 
>  ''', ''' || city || 
>  ''', ''' || state_province || 
>  ''', ''' || country_id || ''');'
>from locations;

#### DEPARTAMENTOS
>SELECT 'INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (' 
>  || department_id ||
>  ', ''' || department_name || 
>  ''', ' || location_id || 
>  ', ' || NVL(TO_CHAR(manager_id), 'null') || ');'
>from departments;

#### EMPREGADOS
>SELECT 'INSERT INTO empregados (id_empregado, nome, email,
>telefone, data_contratacao, id_cargo, salario,
>comissao, id_supervisor, id_departamento) VALUES
>(' || employee_id || ', ''' || first_name || ' ' ||
>last_name || ''', ''' || email || ''', ''' ||
>phone_number || ''', ''' ||
>TO_CHAR(hire_date, 'YYYY-MM-DD') || ''', ''' ||
>job_id || ''', ' || salary || ', ' ||
>NVL(TO_CHAR(commission_pct), 'null') || ', ' ||
>NVL(TO_CHAR(manager_id), 'null') || ', ' ||
>NVL(TO_CHAR(department_id), 'null') || ');'
>FROM employees;

#### CARGOS
>SELECT 'INSERT INTO cargos (id_cargo, cargo, salario_minimo,
>  salario_maximo) VALUES (''' 
>  || job_id || 
>  ''', ''' || job_title || 
>  ''', ' || min_salary || ', ' || max_salary || ');'
>from jobs;

#### HISTORICO DE CARGOS
>SELECT 'INSERT INTO historico_cargos (id_empregado, data_inicial, data_final, id_cargo, id_departamento) VALUES (' 
>  || employee_id || ', '''
>  || TO_CHAR(start_date, 'YYYY-MM-DD') || 
>  ''', ''' || TO_CHAR(end_date, 'YYYY-MM-DD') || 
>  ''', ' || job_id ||
>  ', ' || department_id || ');'
>from job_history;
