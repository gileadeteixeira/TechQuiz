/*Qualquer informação conflitante, consultar modelo base em arquivo PDF.
Links utilizados para imagens e questões:
	https://www.qconcursos.com/questoes-de-concursos/disciplinas/tecnologia-da-informacao-nocoes-de-informatica/nuvem-cloud-computing-e-cloud-storage/questoes
	http://www.pucgoias.edu.br/ArquivisWordpress/enade/ciencia-computacao.pdf
    http://www.dsc.ufcg.edu.br/~joseana/OAC_Exercicios.pdf
    https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Sudoku-by-L2G-20050714.svg/1200px-Sudoku-by-L2G-20050714.svg.png
    https://microsofters.com/wp-content/uploads/2015/08/Crea-facilmente-una-unidad-de-red-para-OneDrive.jpg
    https://t2.tudocdn.net/351859?w=1200
*/
CREATE DATABASE TechQuiz;
USE TechQuiz;
CREATE TABLE evento
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50) UNIQUE DEFAULT 'event', 
	semestre VARCHAR(45) NOT NULL
);
CREATE TABLE gerenciador
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	login VARCHAR(45) UNIQUE,
	senha VARCHAR(45)
);
CREATE TABLE membros
(
	matricula INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45) UNIQUE DEFAULT 'user'
);
CREATE TABLE questoes
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45) UNIQUE DEFAULT 'question',
	texto TEXT,
	urlimagem VARCHAR(200) DEFAULT 'sem_imagem'
);
CREATE TABLE bloco
(
	id INT AUTO_INCREMENT,
	nome VARCHAR(45) UNIQUE DEFAULT 'block',
	evento_id INT,
	tempoinicial_questaoatual TIME,
	limite_tempo TIME,
	ponto_acerto INT,
	ponto_erro INT,
	FOREIGN KEY (evento_id) REFERENCES evento(id) ON DELETE CASCADE,
	PRIMARY KEY (id, evento_id)
);
CREATE TABLE equipe
(
	id INT AUTO_INCREMENT,
	nome VARCHAR(45) UNIQUE DEFAULT 'team',
	evento_id INT,
	login VARCHAR(45) UNIQUE,
	senha VARCHAR(45),
	FOREIGN KEY (evento_id) REFERENCES evento(id) ON DELETE CASCADE,
	PRIMARY KEY (id, evento_id)
);
CREATE TABLE questaomultipla
(
	questoes_id INT,
	alternativa_a VARCHAR(100),
	alternativa_b VARCHAR(100),
	alternativa_c VARCHAR(100),
	alternativa_d VARCHAR(100),
	alternativa_correta INT,
	FOREIGN KEY (questoes_id) REFERENCES questoes(id) ON DELETE CASCADE,
	PRIMARY KEY (questoes_id)
);
CREATE TABLE questaovf
(
	questoes_id INT,
	alternativa_correta INT,
	FOREIGN KEY (questoes_id) REFERENCES questoes(id) ON DELETE CASCADE,
	PRIMARY KEY (questoes_id)
);
CREATE TABLE questao_aberta
(
	questoes_id INT,
	rubrica TEXT,
	FOREIGN KEY (questoes_id) REFERENCES questoes(id) ON DELETE CASCADE,
	PRIMARY KEY (questoes_id)
);
CREATE TABLE bloco_questoes
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	questoes_id INT,
	bloco_id INT,
	evento_id INT,
	questaoatual TINYINT,
	FOREIGN KEY (questoes_id) REFERENCES questoes(id) ON DELETE CASCADE,
	FOREIGN KEY (bloco_id, evento_id) REFERENCES bloco(id, evento_id) ON DELETE CASCADE
);
CREATE TABLE bloco_questoes_equipe
(
	questao_id INT,
	bloco_id INT,
	evento_id INT,
	equipe_id INT,
	resposta INT,
	FOREIGN KEY (questao_id) REFERENCES bloco_questoes(id) ON DELETE CASCADE,
	FOREIGN KEY (bloco_id, evento_id) REFERENCES bloco_questoes(bloco_id, evento_id) ON DELETE CASCADE,
	FOREIGN KEY (equipe_id) REFERENCES equipe(id) ON DELETE CASCADE,
	PRIMARY KEY (questao_id, bloco_id, evento_id, equipe_id)
);
CREATE TABLE vinculo
(
	equipe_id INT,
	membros_matricula INT,
	evento_id INT,
	FOREIGN KEY (equipe_id, evento_id) REFERENCES equipe(id, evento_id) ON DELETE CASCADE,
	FOREIGN KEY (membros_matricula) REFERENCES membros(matricula) ON DELETE CASCADE,
	PRIMARY KEY (equipe_id, membros_matricula, evento_id)
);
/*Inserção*/
INSERT INTO evento (nome, semestre) VALUES ('TechQuiz2019', '1o Semestre');
INSERT INTO gerenciador (login, senha) VALUES ('AlvoDumbledore@unifacs.com', 'mini$tr0dam@gi@');
INSERT INTO membros (nome) VALUES ('Harry'), ('Rony'), ('Hermione'), ('Gina'), ('Luna'), ('Neville'), ('Voldemort'), ('Belatrix'), ('Lucius');
INSERT INTO questoes (nome, texto, urlimagem) VALUES
('Questao 1',
'O Microsoft Windows oferece o serviço de armazenamento OneDrive. Os dados gravados no OneDrive ficam armazenados em:',
'https://microsofters.com/wp-content/uploads/2015/08/Crea-facilmente-una-unidad-de-red-para-OneDrive.jpg'),
('Questao 2', 
'Acerca dos circuitos digitais, julgue os itens abaixo como verdadeiros ou falsos:
( ) O bit de paridade é adicionado ao pacote de dados com o propósito de detecção de erro.
( ) Um circuito de paridade par, com n entradas e uma saída, pode ser implementado por um bloco XOR de n entradas.
( ) Na convenção de paridade-par (even-parity), o valor do bit de paridade é escolhido da tal forma que o número total de dígitos “1” dos dados adicionado ao bit de paridade do pacote seja sempre um número par.
Assinale a alternativa que apresenta a sequência correta:
a) F-V-V. 
b) V-V-F. 
c) V-F-V. 
d) V-V-V.',
'https://microsofters.com/wp-content/uploads/2015/08/Crea-facilmente-una-unidad-de-red-para-OneDrive.jpg'),
('Questao 3',
'O jogo Sudoku consiste em uma matriz 9x9 dividida em 9 sub-matrizes 3x3, como mostrado na figura a seguir.
A matriz está parcialmente preenchida com números de 1 a 9, e o objetivo do jogo é completar a matriz, de forma que cada linha, coluna e sub-matriz contenham todos os números de 1 a 9.
A partir dessas informações, escreva um algoritmo recursivo baseado em retrocesso (backtracking) para resolver o jogo.',
'https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Sudoku-by-L2G-20050714.svg/1200px-Sudoku-by-L2G-20050714.svg.png');
INSERT INTO bloco (nome, evento_id, tempoinicial_questaoatual, limite_tempo, ponto_acerto, ponto_erro) VALUES ('Bloco_1', '1', '00:02:00', '00:05:00', '10', '10');
INSERT INTO equipe (nome, evento_id, login, senha) VALUES
('OrdemDaFenix', '1', 'ordemdafenix@unifacs.com', 's@lapr&cis@'),
('Grifinoria', '1', 'casagrifi@unifacs.com', '&$pAda'),
('Evil','1', 'lordv@unifacs.com', '@VadaK&davr@');
INSERT INTO questaomultipla (questoes_id, alternativa_a, alternativa_b, alternativa_c, alternativa_d, alternativa_correta) VALUES
('1', 'Pen Drive.', 'Hard Disk.', 'Memória RAM.', 'Nuvem.', '4');
INSERT INTO questaovf (questoes_id, alternativa_correta) VALUES ('2', '4');
INSERT INTO questao_aberta (questoes_id, rubrica) VALUES ('3',
'Foi usada uma notação em português estruturado, de forma imperativa.
1 Sudoku (i,V)
2 Se i > 81 então Imprime(V) e termine; /* solução encontrada */
3 Senão se V[i]=0 então /* posição a preencher */
4 Repita para x=1 até 9
5 Se NaoHaViolacao(x,i,V) então /* registra e avança */
6 V[i]=x
7 Sudoku(i+1,V)
8 Fim se
9 Fim repita
10 V[i]=0 /* apaga solução anterior */
11 Senão Sudoku(i+1,V) /* pula posição já preenchida */
12 Fim');
INSERT INTO bloco_questoes (questoes_id, bloco_id, evento_id, questaoatual) VALUES
('1', '1', '1', '1'),
('2', '1', '1', '2'),
('3', '1', '1', '3');
INSERT INTO bloco_questoes_equipe (questao_id, bloco_id, evento_id, equipe_id, resposta) VALUES
('1', '1', '1', '1', '2'),
('1', '1', '1', '2', '1'),
('1', '1', '1', '3', '4'),
('2', '1', '1', '1', '3'),
('2', '1', '1', '2', '4'),
('2', '1', '1', '3', '4'),
('3', '1', '1', '1', '12'),
('3', '1', '1', '2', '3'),
('3', '1', '1', '3', '9');
INSERT INTO vinculo (equipe_id, membros_matricula, evento_id) VALUES
('1', '1', '1'),
('1', '2', '1'),
('1', '3', '1'),
('2', '1', '1'),
('2', '2', '1'),
('2', '3', '1'),
('3', '1', '1'),
('3', '2', '1'),
('3', '3', '1');
/*Update*/
UPDATE evento SET nome = 'TechQuiz2020', semestre = '2o Semestre' WHERE id = 1;
UPDATE gerenciador SET senha = 'H0gw@rts' WHERE id > 0;
UPDATE membros SET nome = 'H. Potter' WHERE matricula < 2;
UPDATE questoes SET urlimagem = 'https://t2.tudocdn.net/351859?w=1200' WHERE nome = 'Questao 1';
UPDATE questoes SET texto = 'Acerca dos circuitos digitais, julgue os itens abaixo como verdadeiros ou falsos:
( ) O bit de paridade é adicionado ao pacote de dados com o propósito de detecção de erro.
( ) Um circuito de paridade par, com n entradas e uma saída, pode ser implementado por um bloco XOR de n entradas.
( ) Na convenção de paridade-par (even-parity), o valor do bit de paridade é escolhido da tal forma que o número total de dígitos “1” dos dados adicionado ao bit de paridade do pacote seja sempre um número par.
Assinale a alternativa que apresenta a sequência correta:
a) F-F-F. 
b) V-V-F. 
c) V-V-V. 
d) V-F-F.', urlimagem = DEFAULT WHERE nome = 'Questao 2';
UPDATE bloco SET limite_tempo = '00:20:00' WHERE evento_id = 1;
UPDATE equipe SET login = 'thegrifis@unifacs.com' WHERE senha LIKE '&_____';
UPDATE questaomultipla SET alternativa_b = 'Disco Rígido' WHERE alternativa_correta LIKE 'N%';
UPDATE questaovf SET alternativa_correta = 3 WHERE questoes_id = 1;
UPDATE questao_aberta SET rubrica =
'Foi usada uma notação em português estruturado, de forma imperativa.
Passo 1 Sudoku (i,V)
Passo 2 Se i > 81 então Imprime(V) e termine; /* solução encontrada */
Passo 3 Senão se V[i]=0 então /* posição a preencher */
Passo 4 Repita para x=1 até 9
Passo 5 Se NaoHaViolacao(x,i,V) então /* registra e avança */
Passo 6 V[i]=x
Passo 7 Sudoku(i+1,V)
Passo 8 Fim se
Passo 9 Fim repita
Passo 10 V[i]=0 /* apaga solução anterior */
Passo 11 Senão Sudoku(i+1,V) /* pula posição já preenchida */
Passo 12 Fim' WHERE questoes_id <> 2;
UPDATE bloco_questoes_equipe SET resposta = 1 WHERE equipe_id = 2;
/*vinculo não será modificado pois é composto apenas por chaves estrangeiras.
Para modificar, precisaria mudar todos os ids anteriores, sendo mais trabalhoso.*/
/*Deleção*/
DELETE FROM evento WHERE id = 1;
DELETE FROM questoes WHERE id < 4;
DELETE FROM membros WHERE matricula <10;
DELETE FROM gerenciador WHERE id = 1;

/*IDEIA ORIGINAL - apagar "manualmente" dados especificos (apagar uns, manter outros):
	DELETE FROM evento WHERE semestre = '2o Semestre';
	DELETE FROM gerenciador WHERE senha = 'H_______';
	DELETE FROM membros WHERE nome = 'H%';
	DELETE FROM questoes WHERE urlimagem = 'https%';
	DELETE FROM bloco WHERE evento_id = 1;
	DELETE FROM equipe WHERE nome <> 'Evil';
	DELETE FROM questaomultipla WHERE questoes_id < 2;
	DELETE FROM questaovf WHERE alternativa_correta > 1;
	DELETE FROM questao_aberta WHERE questoes_id <> 2;
	DELETE FROM bloco_questoes WHERE questaoatual < 4;
	DELETE FROM bloco_questoes_equipe WHERE equipe_id = 2;
	DELETE FROM vinculo WHERE equipe_id = 2;
Mas, ao realizar os testes de funcionamento, sempre aparecia o erro 1451, indicando que não é possivel deletar um dado que seja FK em outra tabela.
Pesquisando sobre o assunto descobri as configurações ON DELETE e tentei aplicar:
	ON DELETE RESTRICT/ ON DELETE NO ACTION - basicamente são as padrões do sistema. Provavelmente as responsaveis por informar o erro.
	ON DELETE SET NULL - Não se aplica aqui, ja que as FK são PK de outras tabelas. PK n pode ser NULL, então a operação se torna invalida.
	ON DELETE SET DEFAULT - Era a melhor, mas dava erro 1005 na hora da criação da tabela (exigia NULL ao inves de DEFAULT).
	ON DELETE CASCADE - A ultima possibilidade, e a unica que funcionou. Infelizmente essa opção acaba apagando TODOS os dados seguintes, resultando em tabelas vazias.*/