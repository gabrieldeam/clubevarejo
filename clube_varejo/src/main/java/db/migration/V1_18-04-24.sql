*Comando SQL para modificar a tabela nota_fiscal_venda porque foi criado uma restrição automantica no venda_compra_id*

select constraint_name from information_schema.constraint_column_usage where table_name = 'nota_fiscal_venda' and column_name = 'venda_compra_id'and constraint_name <> 'unique_acesso_user';

alter table nota_fiscal_venda drop CONSTRAINT "uk_11ssicgkq10kt8n0vt6n24aak";






*Comando SQL para modificar a tabela venda_compra porque foi criado uma restrição automantica no nota_fiscal_venda_id*

select constraint_name from information_schema.constraint_column_usage where table_name = 'venda_compra' and column_name = 'nota_fiscal_venda_id'and constraint_name <> 'unique_acesso_user';

alter table venda_compra drop CONSTRAINT "uk_sygm1jpk3dtjc439yb1y9lf9n";