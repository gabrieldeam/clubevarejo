Criação do Trigger para não deixar cadatrar algo sem ter uma pessoa associada:

Trigger para pessoa_id:

CREATE OR REPLACE FUNCTION validaChavePessoa()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE 
    existe integer;
BEGIN
    -- Verifica se o ID da pessoa existe na tabela pessoa_fisica
    SELECT count(1) INTO existe FROM pessoa_fisica WHERE id = NEW.pessoa_id;
    
    -- Se não encontrou na pessoa_fisica, verifica na pessoa_juridica
    IF (existe <= 0) THEN
        SELECT count(1) INTO existe FROM pessoa_juridica WHERE id = NEW.pessoa_id;
        IF (existe <= 0) THEN
            RAISE EXCEPTION 'Não foi encontrado o ID e PK da pessoa para realizar a associação do cadastro';
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$;


Trigger para pessoa_forn_id:

CREATE OR REPLACE FUNCTION validaChavePessoa2()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE 
    existe integer;
BEGIN
    -- Verifica se o ID da pessoa existe na tabela pessoa_fisica
    SELECT count(1) INTO existe FROM pessoa_fisica WHERE id = NEW.pessoa_forn_id;
    
    -- Se não encontrou na pessoa_fisica, verifica na pessoa_juridica
    IF (existe <= 0) THEN
        SELECT count(1) INTO existe FROM pessoa_juridica WHERE id = NEW.pessoa_forn_id;
        IF (existe <= 0) THEN
            RAISE EXCEPTION 'Não foi encontrado o ID e PK da pessoa para realizar a associação do cadastro';
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$;


Chamada:

CREATE TRIGGER validaChavePessoaUpdate
BEFORE UPDATE
ON nome_da_tabela
FOR EACH ROW
EXECUTE FUNCTION validaChavePessoa();

CREATE TRIGGER validaChavePessoaInsert 
BEFORE INSERT
ON nome_da_tabela
FOR EACH ROW
EXECUTE FUNCTION validaChavePessoa();