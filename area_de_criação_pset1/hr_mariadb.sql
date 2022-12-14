
CREATE TABLE cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo DECIMAL(8,2),
                salario_maximo DECIMAL(8,2),
                PRIMARY KEY (id_cargo)
);

ALTER TABLE cargos COMMENT 'Tabela cargos, que armazena os cargos existentes e a faixa salarial (mínimo
e máximo) para cada cargo.';

ALTER TABLE cargos MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Chave primária da tabela

cargos ''id_cargo'' >> empregado ''id_cargo''; 
cargos ''id_cargo'' >> historico_cargos ''id_cargos'';';

ALTER TABLE cargos MODIFY COLUMN cargo VARCHAR(35) COMMENT 'Nome do cargo.';

ALTER TABLE cargos MODIFY COLUMN salario_minimo DECIMAL(8, 2) COMMENT 'O menor salário admitido para um cargo.';

ALTER TABLE cargos MODIFY COLUMN salario_maximo DECIMAL(8, 2) COMMENT 'O maior salário admitido para um cargo.';


CREATE UNIQUE INDEX cargos_idx
 ON cargos
 ( cargo );

CREATE TABLE regioes (
                id_regiao INT NOT NULL,
                nome VARCHAR(25),
                PRIMARY KEY (id_regiao)
);

ALTER TABLE regioes MODIFY COLUMN id_regiao INTEGER COMMENT 'Chave primária da tabela regiões.';

ALTER TABLE regioes MODIFY COLUMN nome VARCHAR(25) COMMENT 'Nomes das regiões.';


CREATE UNIQUE INDEX regioes_idx
 ON regioes
 ( nome );

CREATE TABLE paises (
                id_pais CHAR(2) NOT NULL,
                nome VARCHAR(50),
                id_regiao INT,
                PRIMARY KEY (id_pais)
);

ALTER TABLE paises COMMENT 'Tabela com as informaçõs dos países.';

ALTER TABLE paises MODIFY COLUMN id_pais CHAR(2) COMMENT 'Chave primária da tabela países.';

ALTER TABLE paises MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome do país.';

ALTER TABLE paises MODIFY COLUMN id_regiao INTEGER COMMENT 'Chave estrangeira para a tabela de regiões.';


CREATE UNIQUE INDEX paises_idx
 ON paises
 ( nome );

CREATE TABLE localizacoes (
                id_localizacao INT NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50) NOT NULL,
                uf VARCHAR(25),
                id_pais CHAR(2),
                PRIMARY KEY (id_localizacao)
); 

ALTER TABLE localizacoes COMMENT 'Tabela localizaçõs. Contém os endereços de diversos escritórios e facilidades
da empresa. Não armazena endereços de clientes.';

ALTER TABLE localizacoes MODIFY COLUMN id_localizacao INTEGER COMMENT 'Chave primária da tabela.';

ALTER TABLE localizacoes MODIFY COLUMN endereco VARCHAR(50) COMMENT 'Endereço (logradouro, número) de um escritório ou facilidade da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN cep VARCHAR(12) COMMENT 'CEP da localização de um escritório ou facilidade da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN cidade VARCHAR(50) COMMENT 'Cidade onde está localizado o escritório ou outra facilidade da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN uf VARCHAR(25) COMMENT 'Estado (abreviado ou por extenso) onde está localizado o escritório ou outra
facilidade da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN id_pais CHAR(2) COMMENT 'Chave estrangeira para a tabela de países.';


CREATE TABLE departamentos (
                id_departamento INT NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_localizacao INT,
                id_gerente INT,
                PRIMARY KEY (id_departamento)
);

ALTER TABLE departamentos COMMENT 'Tabela com as informações sobre os departamentos da empresa.';

ALTER TABLE departamentos MODIFY COLUMN id_departamento INTEGER COMMENT 'Chave primária da tabela.

departamentos ''id_departamento'' >> empregados ''id_departamento'';

departamentos ''id_departamento'' >> historico_cargos ''id_departamento'';';

ALTER TABLE departamentos MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome do departamento da tabela.';

ALTER TABLE departamentos MODIFY COLUMN id_localizacao INTEGER COMMENT 'Chave estrangeira para a tabela de empregados, representando qual empregado,
se houver, é o gerente deste departamento.

localizacoes ''id_localizacao'' >> departamento ''id_localizacao'';';

ALTER TABLE departamentos MODIFY COLUMN id_gerente INTEGER COMMENT 'Chave estrangeira para a tabela de localizações.

empregados ''id_empregado'' >> departamentos ''id_gerente'';';


CREATE UNIQUE INDEX departamentos_idx
 ON departamentos
 ( nome );

CREATE TABLE empregados (
                id_empregado INT NOT NULL,
                nome VARCHAR(75),
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario DECIMAL(8,2),
                comissao DECIMAL(8,2),
                id_departamento INT,
                id_supervisor INT,
                PRIMARY KEY (id_empregado)
);

ALTER TABLE empregados COMMENT 'Tabela que contém as informações dos empregados.';

ALTER TABLE empregados MODIFY COLUMN id_empregado INTEGER COMMENT 'Chave primária da tabela.

empregados ''id_empregado'' >> empregados ''id_empregado'';

empregados ''id_empregado'' >> departamentos ''id_empregado'';

empregados ''id_empregado'' >> historico_cargos ''id_empregado'';';

ALTER TABLE empregados MODIFY COLUMN nome VARCHAR(75) COMMENT 'Nome completo do empregado.';

ALTER TABLE empregados MODIFY COLUMN email VARCHAR(35) COMMENT 'Parte inicial do email do empregado (antes do @).';

ALTER TABLE empregados MODIFY COLUMN telefone VARCHAR(20) COMMENT 'Telefone do empregado (há espaço para o código do país e estado).';

ALTER TABLE empregados MODIFY COLUMN data_contratacao DATE COMMENT 'Data que o empregado iniciou no cargo atual.';

ALTER TABLE empregados MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Chave estrangeiro para a tabela cargos. Indica o cargo atual do empregado.

cargos ''id_cargos'' >> empregados ''id_cargos'';';

ALTER TABLE empregados MODIFY COLUMN salario DECIMAL(8, 2) COMMENT 'Salário mensal atual do empregado.';

ALTER TABLE empregados MODIFY COLUMN comissao DECIMAL(8, 2) COMMENT 'Porcentagem de comissão de um empregado. Apenas empregados no departamento
de vendas são elegíveis para comissões.';

ALTER TABLE empregados MODIFY COLUMN id_departamento INTEGER COMMENT 'Chave estrangeira para a tabela de departamentos. Indica o departamento atual
de um empregado.

departamentos ''id_departamentos'' >> empregados ''id_departamentos'';';

ALTER TABLE empregados MODIFY COLUMN id_supervisor INTEGER COMMENT 'Chave estrangeira para a própria tabela empregados (auto-relacionamento).
Indica o supervisor direto do empregado (pode corresponder ou não ao manager_id
do departamento do empregado).';


CREATE UNIQUE INDEX empregados_idx
 ON empregados
 ( email );

CREATE TABLE historico_cargos (
                id_empregado INT NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INT,
                PRIMARY KEY (id_empregado, data_inicial)
);

ALTER TABLE historico_cargos COMMENT 'Tabela que armazena o histórico de cargos de um empregado. Se um empregado
mudar de departamento dentro de um cargo ou mudar de cargo dentro de um
departamento, novas linhas devem ser inseridas nesta tabela com a informação
antiga do empregado.';

ALTER TABLE historico_cargos MODIFY COLUMN id_empregado INTEGER COMMENT 'Parte da chave primária composta da tabela (empregado_id e data_inicial).
Também é uma chave estrangeira para a tabela empregados.';

ALTER TABLE historico_cargos MODIFY COLUMN data_inicial DATE COMMENT 'Parte da chave primária composta da tabela (empregado_id e data_inicial).
Indica a data inicial do empregado em um novo cargo. Deve ser menor do que a
data_final.';

ALTER TABLE historico_cargos MODIFY COLUMN data_final DATE COMMENT 'Último dia de um empregado neste cargo. Deve ser maior do que a data inicial.';

ALTER TABLE historico_cargos MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Chave estrangeira para a tabela de cargos. Corresponde ao cargo em que o
empregado estava trabalhando no passado.';

ALTER TABLE historico_cargos MODIFY COLUMN id_departamento INTEGER COMMENT 'Chave estrangeira para a tabela de departamentos. Corresponde ao departamento
em que o empregado estava trabalhando no passado.';


ALTER TABLE empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
