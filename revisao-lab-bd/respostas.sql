--01
SELECT
    ' O identificador da função ' || ds_funcao || ' é o ID: ' || id_funcao AS "Descrição da função"
FROM
    tb_funcao;

--=================================================================================================

--02
SELECT
    (POWER(6000, 2) * (22 / 7)) AS "Area"
FROM
    dual;

--=================================================================================================

--03
SELECT
    nm_departamento
FROM
    tb_departamento
WHERE
    nm_departamento LIKE '_%ing';

--=================================================================================================

--04
SELECT
    ds_funcao,
    base_salario,
    TO_NUMBER(teto_salario) - TO_NUMBER(base_salario) AS "DIFERENCA"
FROM
    tb_funcao
WHERE
    ds_funcao LIKE 'Presidente'
    OR ds_funcao LIKE 'Gerente%_'
ORDER BY
    DIFERENCA DESC;

--=================================================================================================

--05
SELECT
    &&v_id_empregado,
    nome,
    sobrenome,
    salario,
    TO_NUMBER(salario * 12) AS "Salario anual",
    &&v_aliquota AS "Aliquota",
    TO_NUMBER((100 / & & v_aliquota) *(salario * 12)) AS "Aliquota x Salario anual"
FROM
    tb_empregado
WHERE
    id_empregado = &&v_id_empregado;

--=================================================================================================

--EXERCÍCIO 06
CREATE TABLE tb_mulher (
id_mulher    INTEGER,
nome_mulher  VARCHAR2(10),
CONSTRAINT pk_tb_mulher_id_mulher PRIMARY KEY (id_mulher));

CREATE TABLE tb_homem (
id_homem     INTEGER,
nome_homem   VARCHAR2(10),
id_mulher    INTEGER,
CONSTRAINT pk_tb_homem_id_homem PRIMARY KEY (id_homem),
CONSTRAINT fk_tb_homem_id_mulher FOREIGN KEY (id_mulher) REFERENCES
tb_mulher (id_mulher));

--6.1
INSERT INTO tb_homem (id_homem, nome_homem, id_mulher)
VALUES (10, 'Anderson', NULL);
INSERT INTO tb_homem (id_homem, nome_homem, id_mulher)
VALUES (20, 'Jander', 1);
INSERT INTO tb_homem (id_homem, nome_homem, id_mulher)
VALUES (30, 'Rogerio', 2);

COMMIT;

--6.2
INSERT INTO tb_mulher (id_mulher, nome_mulher)
VALUES (1, 'Edna');
INSERT INTO tb_mulher (id_mulher, nome_mulher)
VALUES (2, 'Stefanny');
INSERT INTO tb_mulher (id_mulher, nome_mulher)
VALUES (3, 'Cassia');

COMMIT;

--6.3
SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS "Casamentos" FROM tb_homem h, tb_mulher m
WHERE h.id_mulher = m.id_mulher;

SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS "Casamentos" FROM tb_homem h
NATURAL JOIN tb_mulher m;

SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS "Casamentos" FROM tb_homem h
INNER JOIN tb_mulher m
USING (id_mulher);

SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS "Casamentos" FROM tb_homem h
INNER JOIN tb_mulher m
ON h.id_mulher = m.id_mulher;

SELECT * FROM tb_homem h
CROSS JOIN tb_mulher m;

SELECT * FROM tb_homem, tb_mulher;

--6.4
SELECT h.nome_homem, m.nome_mulher FROM tb_homem h, tb_mulher m
WHERE h.id_mulher = m.id_mulher (+);

SELECT h.nome_homem, m.nome_mulher FROM tb_homem h, tb_mulher m
WHERE h.id_mulher (+) = m.id_mulher;

SELECT h.nome_homem, m.nome_mulher FROM tb_homem h
LEFT OUTER JOIN tb_mulher m USING (id_mulher);

SELECT h.nome_homem, m.nome_mulher FROM tb_homem h
RIGHT OUTER JOIN tb_mulher m USING (id_mulher);

SELECT h.nome_homem, m.nome_mulher FROM tb_homem h
LEFT OUTER JOIN tb_mulher m ON h.id_mulher = m.id_mulher;

SELECT h.nome_homem, m.nome_mulher FROM tb_homem h
RIGHT OUTER JOIN tb_mulher m ON h.id_mulher = m.id_mulher;

SELECT h.nome_homem, m.nome_mulher FROM tb_homem h
FULL OUTER JOIN tb_mulher m ON h.id_mulher = m.id_mulher;

--=================================================================================================

/*
EXERCÍCIO 07

7.1. Elabore uma consulta para exibir o nome do empregado, sua respectiva 
descrição da função e a data de admissão dos empregados admitidos entre o 
período de 20 de fevereiro de 1987 e 1 de maio de 1989. Ordene a consulta 
resultante de modo ascendente de maneira posicional pela data de admissão.
*/

SELECT e.nome, f.ds_funcao, e.data_admissao FROM tb_empregado e
INNER JOIN tb_funcao f ON (e.id_funcao = f.id_funcao)
WHERE data_admissao BETWEEN '20/feb/1987' AND '01/may/1989'
ORDER BY data_admissao ASC;

SELECT e.nome, f.ds_funcao, e.data_admissao FROM tb_empregado e
INNER JOIN tb_funcao f ON (e.id_funcao = f.id_funcao)
WHERE data_admissao >= '20/FEB/1987' AND data_admissao <= '01/MAY/1989'
ORDER BY data_admissao ASC;

/*
7.2. Elabore uma consulta para exibir o nome do empregado com todas as letras em 
maiúsculo, além do tamanho do sobrenome (quantidade de caracteres), nome do 
departamento e nome do país, para todos os empregados cujo nome inicia-se 
pelos caracteres B, L ou A. Forneça um label apropriado para cada coluna.
*/

SELECT UPPER(e.nome) AS "Nome em maiusculo",
LENGTH(e.sobrenome)  AS "Quantidade de letras no sobrenome", 
d.nm_departamento, p.nm_pais
FROM tb_empregado e
INNER JOIN tb_departamento d ON (e.id_departamento = d.id_departamento)
INNER JOIN tb_localizacao l  ON (d.id_localizacao = l.id_localizacao)
INNER JOIN tb_pais p         ON (l.id_pais = p.id_pais)
WHERE e.nome LIKE 'B%' AND e.nome LIKE 'L%' OR e.nome LIKE 'A%';

/*
7.3. Elabore uma consulta para exibir o nome do empregado, o nome do departamento
e sua respectiva localização (cidade e estado) de todos os empegados 
que recebem comissão.
*/

SELECT e.nome, d.nm_departamento, l.cidade, l.estado FROM tb_empregado e
INNER JOIN tb_departamento d USING (id_departamento)
INNER JOIN tb_localizacao l USING (id_localizacao)
WHERE percentual_comissao IS NOT NULL;



/*
7.4. Realize uma Auto Junção para recuperar o nome de cada empregado juntamente
com o nome de seu respectivo gerente. Exemplo: João trabalha para o Tiago. 
Todos os empregados deverão ser recuperados, sem exceção. Para o empregado 
que NÃO possuir gerente vinculado, utilize a função apropriada do Oracle para 
substituir o valor nulo (NULL) do nome do gerente para o STRING “os acionistas”. 
Ordene de maneira descendente à relação resultante pelo NOME do gerente.
*/

SELECT e.nome || ' trabalha para ' || NVL(g.nome, 'Os acionistas') 
FROM tb_empregado e
LEFT OUTER JOIN tb_empregado g ON (g.id_empregado = e.id_gerente)
ORDER BY g.nome DESC;

/*
7.5. Elabore um procedimento armazenado utilizando a linguagem PL/SQL a qual
receberá 1 parâmetro do tipo inteiro, representando o id_empregado.
Identifique esse stored procedure de sp_get_emp(p_id integer).
O procedimento armazenado deverá retornar o nome completo,
juntamente com a descrição da função que o empregado correspondente
ao ID informado como parâmetro de entrada (IN) exerce atualmente. Se,
eventualmente, o usuário informar um ID de empregado inexistente,
exibir uma mensagem informativa.
*/

create or replace PROCEDURE
          sp_get_emp(
                p_id_empregado IN tb_empregado.id_empregado%TYPE
                    )
                    AS
                v_nome            tb_empregado.nome%TYPE;
                v_sobrenome       tb_empregado.sobrenome%TYPE;
                v_ds_funcao       tb_funcao.ds_funcao%TYPE;
                v_controle        INTEGER;

        BEGIN
            SELECT COUNT(*) INTO v_controle
            FROM tb_empregado
            INNER JOIN tb_funcao USING (id_funcao)
            WHERE id_empregado = p_id_empregado;

        IF (v_controle = 1) THEN
          SELECT nome, sobrenome, ds_funcao INTO v_nome, v_sobrenome, v_ds_funcao
            FROM tb_empregado
            INNER JOIN tb_funcao USING (id_funcao)
            WHERE id_empregado = p_id_empregado;
            
            DBMS_OUTPUT.PUT_LINE ('Nome: ' || v_nome || ' ' || v_sobrenome || ' Funcao: ' || v_ds_funcao );

        ELSE
            DBMS_OUTPUT.PUT_LINE ('Empregado ' || p_id_empregado || ' nao localizado!!!');
        END IF;       
END sp_get_emp;