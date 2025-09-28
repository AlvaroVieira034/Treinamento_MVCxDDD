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

select * from bdtestedguarani.dbo.tab_pedido


select * from bdtestedguarani.dbo.tab_cliente

select * from bdtestedguarani.dbo.tab_pedido


sp_help tab_produto


select * from tab_produto

select * from bdtestedguarani.dbo.tab_pedido_item

select count(*) as quant from tab_pedido_item where cod_produto = 17

select count(*) as quant from tab_produto where des_descricao = 'BBBB' and cod_produto <> 34

select * from bdtestedguarani.dbo.tab_pedido
select * from bdtestedguarani.dbo.tab_pedido_item

select ped.cod_pedido,  
ped.dta_pedido, 
ped.cod_cliente, 
ped.val_pedido 
from tab_pedido ped
where cod_pedido = 40

select * from bdtestedguarani.dbo.tab_pedido_item
where cod_pedido = 40



DECLARE @DataInicio DATE = NULL;      -- informe a data inicial ou deixe NULL
DECLARE @DataFim DATE = NULL;         -- informe a data final ou deixe NULL
DECLARE @MostrarTodos BIT = 1;        -- 1 = lista todos, 0 = lista só os TOP 2

SELECT TOP (
    CASE WHEN @MostrarTodos = 1 THEN 2147483647 ELSE 2 END
)
    p.cod_produto,
    pr.des_descricao,
    pr.des_marca,
    SUM(p.val_quantidade) AS QuantidadeVendida,
    SUM(p.val_totalitem)  AS ValorTotalVendido
FROM tab_pedido_item p
JOIN tab_pedido ped ON p.cod_pedido = ped.cod_pedido
JOIN tab_produto pr ON p.cod_produto = pr.cod_produto
WHERE (@DataInicio IS NULL OR ped.dta_pedido >= @DataInicio)
  AND (@DataFim IS NULL OR ped.dta_pedido <= @DataFim)
GROUP BY p.cod_produto, pr.des_descricao, pr.des_marca
ORDER BY SUM(p.val_quantidade) DESC;



DECLARE @DataInicio DATE = NULL;      -- informe a data inicial ou deixe NULL
DECLARE @DataFim DATE = NULL;         -- informe a data final ou deixe NULL
DECLARE @MostrarTodos BIT = 1;        -- 1 = lista todos, 0 = lista só os TOP 2


SELECT TOP (
CASE WHEN @MostrarTodos = 1 THEN 2147483647 ELSE 2 END)
p.cod_produto, 
pr.des_descricao, 
pr.des_marca, 
SUM(p.val_quantidade) AS QuantidadeVendida, 
SUM(p.val_totalitem)  AS ValorTotalVendido 
FROM tab_pedido_item p 
JOIN tab_pedido ped ON p.cod_pedido = ped.cod_pedido 
JOIN tab_produto pr ON p.cod_produto = pr.cod_produto 
WHERE (@DataInicio IS NULL OR ped.dta_pedido >= @DataInicio) 
AND (@DataFim IS NULL OR ped.dta_pedido <= @DataFim) 
GROUP BY p.cod_produto, pr.des_descricao, pr.des_marca 
ORDER BY SUM(p.val_quantidade) DESC



update bdtestedguarani.dbo.tab_cliente set des_documento = des_cnpj

alter table bdtestedguarani.dbo.tab_cliente add des_documento varchar(18)

select * from bdtestedguarani.dbo.tab_cliente
