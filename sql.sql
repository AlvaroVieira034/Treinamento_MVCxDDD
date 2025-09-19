select * from bdtestedguarani.dbo.tab_cliente

select count(*) as quant from tab_cliente where des_cnpj = '64.238.959/0001-42'	

select count(*) as quant from tab_cliente where des_cnpj = '45.456.454/5645-64' AND cod_cliente <> 6

select * from tab_cliente where des_cnpj = '64.238.959/0001-42'	

delete from bdtestedguarani.dbo.tab_cliente where cod_cliente = 38;

alter table bdtestedguarani.dbo.tab_cliente add des_logradouro varchar(100)
alter table bdtestedguarani.dbo.tab_cliente add des_numero varchar(15)
alter table bdtestedguarani.dbo.tab_cliente add des_email varchar(100)

update bdtestedguarani.dbo.tab_cliente set des_logradouro = des_endereco

alter table bdtestedguarani.dbo.tab_cliente drop column des_endereco


select * from bdtestedguarani.dbo.tab_cliente