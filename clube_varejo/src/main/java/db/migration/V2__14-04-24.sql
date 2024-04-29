select constraint_name from information_schema.constraint_column_usage where table_name = 'usuario_acesso' and column_name = 'acesso_id'and constraint_name <> 'unique_acesso_user';

alter table usuario_acesso drop CONSTRAINT "uk_fhwpg5wu1u5p306q8gycxn9ky";

select constraint_name from information_schema.constraint_column_usage where table_name = 'nota_fiscal_venda' and column_name = 'venda_compra_id'and constraint_name <> 'unique_acesso_user';

alter table nota_fiscal_venda drop CONSTRAINT "uk_11ssicgkq10kt8n0vt6n24aak";

select constraint_name from information_schema.constraint_column_usage where table_name = 'venda_compra' and column_name = 'nota_fiscal_venda_id'and constraint_name <> 'unique_acesso_user';

alter table venda_compra drop CONSTRAINT "uk_sygm1jpk3dtjc439yb1y9lf9n";