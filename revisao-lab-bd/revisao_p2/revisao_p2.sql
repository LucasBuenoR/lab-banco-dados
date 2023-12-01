--==================================================REVISÃO==================================================--

--==================================================FUNÇÕES AGREGADAS==================================================--

SELECT * FROM tb_produtos;

SELECT AVG(preco) FROM tb_produtos;

SELECT AVG(preco + 2)
FROM tb_produtos;

SELECT AVG(DISTINCT preco)
FROM tb_produtos;

SELECT COUNT(id_produto)
FROM tb_produtos;

SELECT MAX(preco), MIN(preco)
FROM tb_produtos;

SELECT MAX(nm_produto), MIN(nm_produto)
FROM tb_produtos;

SELECT MAX(dt_nascimento), MIN(dt_nascimento)
FROM tb_clientes;

-- STDDEV -> DESVIO PADRÃO
SELECT STDDEV(preco)
FROM tb_produtos;

-- SUM -> SOMA
SELECT SUM(preco)
FROM tb_produtos;

-- VARIANCE
SELECT VARIANCE(preco)
FROM tb_produtos;

--==================================================AGRUPANDO LINHAS==================================================--

SELECT id_tipo_produto
FROM tb_produtos
GROUP BY id_tipo_produto;

SELECT id_produto, id_cliente
FROM tb_compras
GROUP BY id_produto, id_cliente;

SELECT id_tipo_produto, COUNT(ROWID)
FROM tb_produtos
GROUP BY id_tipo_produto
ORDER BY id_tipo_produto;

SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
ORDER BY id_tipo_produto;

SELECT id_tipo_produto, VARIANCE(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
ORDER BY id_tipo_produto;

SELECT VARIANCE(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
ORDER BY VARIANCE(preco);

SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
HAVING AVG(preco) > 20.00;

SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
WHERE preco < 15.00
GROUP BY id_tipo_produto
ORDER BY id_tipo_produto;

SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
WHERE preco < 15.00
GROUP BY id_tipo_produto
HAVING AVG(preco) > 13.00
ORDER BY id_tipo_produto;

--==================================================MANIPULANDO DATA E HORA==================================================--

SELECT * FROM tb_clientes;

INSERT INTO tb_clientes (id_cliente, nome, sobrenome, dt_nascimento, telefone, fg_ativo)
VALUES (13, 'Steve', 'Purple', DATE'1972-10-25', '800-555-1200', 1);

ROLLBACK;

SELECT id_cliente, TO_CHAR(dt_nascimento, 'MONTH DD, YYYY') AS "DATA DE NASCIMENTO"
FROM tb_clientes;

SELECT TO_CHAR(SYSDATE, 'MONTH DD, YYYY, HH24:MI:SS') AS "TEMPO ATUAL"
FROM dual;

SELECT TO_CHAR(TO_DATE('05-FEB-1968'), 'MONTH DD, YYYY')
FROM dual;

SELECT TO_DATE('04-JUL-2013'), TO_DATE('04-JUL-13')
FROM dual;

SELECT TO_DATE('JUL 04, 2013', 'MONTH DD, YYYY')
FROM dual;

-- CONSULTANDO PARAMETROS
SELECT * FROM nls_session_parameters;
--CONFIGURANDO DATE_FORMAT
ALTER SESSION SET NLS_DATE_FORMAT = 'Mon/dd/yyyy';

SELECT TO_DATE('7.4.13', 'MM.DD.YY') FROM dual;

INSERT INTO tb_clientes(id_cliente, nome, sobrenome, dt_nascimento, telefone, fg_ativo)
VALUES (10, 'Nome', 'Sobrenome', TO_DATE('jul 04, 2013 19:32:36', 'MONTH DD, YYYY HH24:MI:SS'),
'800-555-1220', 1);

SELECT * FROM tb_clientes;

SELECT id_cliente,
     TO_CHAR(dt_nascimento, 'DD-MON-YYYY HH24:MI:SS') AS "DATA E HORA"
FROM tb_clientes
ORDER BY id_cliente;

ROLLBACK;

SELECT TO_CHAR(TO_DATE('jul 04, 2013 19:32:36',
'MONTH DD, YYYY HH24:MI:SS'), 'HH24:MI:SS')
FROM dual;

-- CONFIGURANDO DATE_FORMAT
SELECT * FROM nls_session_parameters;
ALTER SESSION SET NLS_DATE_FORMAT = 'Mon/dd/yyyy';

SELECT
     TO_CHAR(TO_DATE('jul 04, 15','MONTH DD, YY'), 'MONTH DD, YYYY'),
     TO_CHAR(TO_DATE('jul 04, 75','MONTH DD, YY'), 'MONTH DD, YYYY')
FROM dual;

SELECT
     TO_CHAR(TO_DATE('jul 04, 15','MONTH DD, RR'), 'MONTH DD, YYYY'),
     TO_CHAR(TO_DATE('jul 04, 75','MONTH DD, RR'), 'MONTH DD, YYYY')
FROM dual;

-- SOMA 13 MESES A 1 DE JULHO DE 2013
SELECT ADD_MONTHS('jul 01, 2013', 13) FROM dual;

-- SUBTRAI 13 MESES A 1 DE JULHO DE 2013
SELECT ADD_MONTHS('jul 01, 2013', -13) FROM dual;

-- EXIBIR A ULTIMA DATE EM JULHO DE 2013
SELECT LAST_DAY('jul 01, 2013')
FROM dual;

-- EXIBIR O NUMERO DE MESES ENTRE 1 DE MMAIO DE 2011 E 03 DE JULHO DE 2013
SELECT MONTHS_BETWEEN('Jul 03, 2013', 'May 01, 2011')
FROM dual;

-- EXIBIR A DATA DO PROXIMO DOMINGO, APOS 03 DE JULHO DE 2013
SELECT NEXT_DAY('Jul 03, 2013', 1)
FROM dual;

-- USANDO O ROUND PARA ARREDONDAR O TEMPO
SELECT ROUND(TO_DATE('jul 03, 2013'), 'YYYY')
FROM dual;

SELECT ROUND(TO_DATE('May 25, 2013'), 'MM')
FROM dual;

SELECT TO_CHAR
      (ROUND
      (TO_DATE('Jul 03, 2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS'),
      'HH24'),
      'MONTH DD, YYYY HH24:MI:SS')
FROM dual;

SELECT SYSDATE FROM dual;

SELECT
   EXTRACT(YEAR FROM TO_DATE('Jul 03, 2013 19:45:26',
      'MONTH DD, YYYY HH24:MI:SS')) AS YEAR,
   EXTRACT(MONTH FROM TO_DATE('Jul 03, 2013 19:45:26',
      'MONTH DD, YYYY HH24:MI:SS')) AS MONTH,
   EXTRACT(DAY FROM TO_DATE('Jul 03, 2013 19:45:26',
      'MONTH DD, YYYY HH24:MI:SS')) AS DAY
FROM dual;

SELECT
   EXTRACT(HOUR FROM TO_TIMESTAMP('Jul 03, 2013 19:45:26',
      'MONTH DD, YYYY HH24:MI:SS')) AS HORA,
   EXTRACT(MINUTE FROM TO_TIMESTAMP('Jul 03, 2013 19:45:26',
      'MONTH DD, YYYY HH24:MI:SS')) AS MINUTO,
   EXTRACT(SECOND FROM TO_TIMESTAMP('Jul 03, 2013 19:45:26',
      'MONTH DD, YYYY HH24:MI:SS')) AS SEGUNDO
FROM dual;

-- INTERVALO DE TEMPO
SELECT
    NUMTODSINTERVAL(1.5,'DAY'),
    NUMTODSINTERVAL(3.25,'HOUR'),
    NUMTODSINTERVAL(5,'MINUTE'),
    NUMTODSINTERVAL(10.123456789,'SECOND')
FROM dual;

SELECT
    NUMTOYMINTERVAL(1.5,'YEAR'),
    NUMTOYMINTERVAL(3.25,'MONTH')
FROM dual;

--==================================================SUBCONSULTAS==================================================--
-- SUBCONSULTAS DE UMA UNICA LINHA
SELECT nome, sobrenome
FROM tb_clientes
WHERE id_cliente = (SELECT id_cliente
                    FROM tb_clientes
                    WHERE sobrenome = 'Blue');

-- OPERADORES UTILIZADOS EM SUBCONSULTAS DE UMA UNICA LINHA (<>, <, >, <=, >=) --
SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE preco > (SELECT AVG(preco)
               FROM tb_produtos);

-- SUBCONSULTA EM UMA CLAUSULA HAVING
SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
HAVING AVG(preco) < (SELECT MAX(AVG(preco))
                     FROM tb_produtos
                     GROUP BY id_tipo_produto)
ORDER BY id_tipo_produto;

-- VISOES INLINE
SELECT id_produto
FROM (SELECT id_produto
      FROM tb_produtos
      WHERE id_produto < 3);
      
SELECT p.id_produto, preco, dados_compra.count_produto
FROM tb_produtos p, (SELECT id_produto, COUNT(id_produto) COUNT_PRODUTO
                     FROM tb_compras
                     GROUP BY id_produto) dados_compra
WHERE p.id_produto = dados_compra.id_produto;

-- SUBCONSULTAS (VARIAS LINHAS)
-- OS OPERADORES UTILIZADOS SAO (IN, ANY, ALL)
-- PERMITE UTILIZAR NOT IN

SELECT id_produto, nm_produto
FROM tb_produtos
WHERE id_produto IN (SELECT id_produto
                     FROM tb_produtos
                     WHERE nm_produto LIKE '%e%');

SELECT id_produto, nm_produto
FROM tb_produtos
WHERE id_produto NOT IN (SELECT id_produto
                         FROM tb_compras);

-- PERMITE INSERIR UM OPERADOR (=, <>, <, >, <=, =>) ANTES DE ANY
SELECT id_funcionario, nome, salario
FROM tb_funcionarios
WHERE salario < ANY (SELECT base_salario
                     FROM tb_grades_salarios);
                     
-- PERMITE INSERIR UM OPERADOR (=, <>, <, >, <=, =>) ANTES DE ALL
SELECT id_funcionario, nome, salario
FROM tb_funcionarios
WHERE salario > ALL (SELECT teto_salario
                     FROM tb_grades_salarios);

-- RETORNANDO VARIAS COLUNAS
SELECT id_produto, id_tipo_produto, nm_produto, preco
FROM tb_produtos
WHERE (id_tipo_produto, preco) IN (SELECT id_tipo_produto, MIN(preco)
                                   FROM tb_produtos
                                   GROUP BY id_tipo_produto);
                                   
-- SUBCONSULTA CORRELACIONADAS
SELECT id_produto, id_tipo_produto, nm_produto, preco
FROM tb_produtos externa
WHERE preco > (SELECT AVG(preco)
               FROM tb_produtos interna
               WHERE interna.id_tipo_produto = externa.id_tipo_produto);

SELECT id_funcionario, nome, sobrenome
FROM tb_funcionarios externa
WHERE EXISTS (SELECT id_funcionario
              FROM tb_funcionarios interna
              WHERE interna.id_gerente = externa.id_funcionario);
              
SELECT id_funcionario, nome, sobrenome
FROM tb_funcionarios externa
WHERE EXISTS (SELECT 1
              FROM tb_funcionarios interna
              WHERE interna.id_gerente = externa.id_funcionario);

SELECT id_produto, nm_produto
FROM tb_produtos externa
WHERE NOT EXISTS (SELECT 1
                  FROM tb_compras interna
                  WHERE interna.id_produto = externa.id_produto);

SELECT id_tipo_produto, nm_tipo_produto
FROM tb_tipos_produtos
WHERE id_tipo_produto NOT IN (SELECT id_tipo_produto
                  FROM tb_produtos
                  );
                  
SELECT * FROM tb_tipos_produtos;
DELETE tb_tipos_produtos WHERE id_tipo_produto = 5;

ROLLBACK;

SELECT id_tipo_produto, nm_tipo_produto
FROM tb_tipos_produtos
WHERE id_tipo_produto NOT IN (SELECT NVL(id_tipo_produto,0)
                  FROM tb_produtos
                  );

-- SUBCONSULTAS ANINHADAS
SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
HAVING AVG(preco) <(SELECT MAX(AVG(preco))
                    FROM tb_produtos
                    WHERE id_produto IN (SELECT id_produto
                                         FROM tb_compras
                                         WHERE quantidade > 1)
                    GROUP BY id_tipo_produto)
ORDER BY id_tipo_produto;

-- UPDATE E DELETE CONTENDO SUBCONSULTAS
SELECT * FROM tb_funcionarios;
UPDATE tb_funcionarios
SET salario = (SELECT AVG(teto_salario)
               FROM tb_grades_salarios)
WHERE id_funcionario =4;

ROLLBACK;

DELETE FROM tb_funcionarios
WHERE salario > (SELECT AVG(teto_salario)
                 FROM tb_grades_salarios);
ROLLBACK;

--==================================================CONSULTAS AVANÇADAS==================================================--

SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
UNION ALL
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos;

SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
UNION
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos;

SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
INTERSECT
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos;

SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
MINUS
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos;

(SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
UNION
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos)
INTERSECT
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_alteracoes_produtos;

SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
UNION
(SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos
INTERSECT
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_alteracoes_produtos);

-- TRANSLATE
SELECT TRANSLATE ('MENSAGEM SECRETA',
       'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
       'EFGHIJKLMNOPQRSTUVWXYZABCD')
FROM dual;

SELECT TRANSLATE (nm_produto,
       'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmmnopqrstuvwxyz',
       'EFGHIJKLMNOPQRSTUVWXYZABCDefghijklmnopqrstuvwxyzabcd')
FROM tb_produtos;

SELECT TRANSLATE(12345,
                 54321,
                 67890)
FROM dual;

-- DECODE
SELECT DECODE(1,1,2,3)
FROM dual;

SELECT DECODE(1,2,1,3)
FROM dual;

SELECT id_produto, disponivel,
      DECODE(disponivel, 'Y', 'Produto esta disponivel',
                              'Produto nao esta disponivel')
FROM tb_mais_produtos;

SELECT * FROM tb_mais_produtos;

SELECT id_produto, id_tipo_produto,
     DECODE(id_tipo_produto,
            1, 'Book',
            2, 'Video',
            3, 'DVD',
            4, 'CD',
               'Magazine')
FROM tb_produtos;

-- CASE
SELECT id_produto, id_tipo_produto,
      CASE id_tipo_produto
         WHEN 1 THEN 'Book'
         WHEN 2 THEN 'Video'
         WHEN 3 THEN 'DVD'
         WHEN 4 THEN 'CD'
         ELSE 'Magazine'
      END
FROM tb_produtos;

SELECT id_produto, id_tipo_produto,
      CASE 
         WHEN id_tipo_produto = 1 THEN 'Book'
         WHEN id_tipo_produto = 2 THEN 'Video'
         WHEN id_tipo_produto = 3 THEN 'DVD'
         WHEN id_tipo_produto = 4 THEN 'CD'
         ELSE 'Magazine'
      END
FROM tb_produtos;

SELECT id_produto, preco,
      CASE
        WHEN preco > 15.00 THEN 'Caro'
        ELSE 'Barato'
      END
FROM tb_produtos;

-- CONSULTAS HIERARQUICAS
SELECT id_funcionario, id_gerente, nome, sobrenome
FROM tb_mais_funcionarios
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente
ORDER BY 1;

-- LEVEL
SELECT LEVEL, id_funcionario, id_gerente, nome, sobrenome
FROM tb_mais_funcionarios
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente
ORDER BY LEVEL;

SELECT LEVEL,
  LPAD(' ', 2*LEVEL -1) || nome || ' ' || sobrenome AS funcionario
FROM tb_mais_funcionarios
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente;