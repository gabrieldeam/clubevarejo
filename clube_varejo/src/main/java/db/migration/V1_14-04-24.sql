*Comando SQL para modificar a tabela usuario_acesso porque foi criado uma restrição automantica no acesso_id*

select constraint_name from information_schema.constraint_column_usage where table_name = 'usuario_acesso' and column_name = 'acesso_id'and constraint_name <> 'unique_acesso_user';

alter table usuario_acesso drop CONSTRAINT "uk_fhwpg5wu1u5p306q8gycxn9ky";