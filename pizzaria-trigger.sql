create database exerciciokkkkj

use exerciciokkkkj

create table tb_produto
(
	Produto varchar(100),
	contagem_caixas_G int,
	contagem_caixas_M int,
	contagem_caixas_P int,
	data_ultima_att datetime
)

insert tb_produto values
('Pizza Calabresa (massa,molho de tomate, calabresa)',1000,1000, 1000,getdate()),
('Pizza Frango(massa,molho de tomate,frango desfiado)',1000,1000,1000, getdate()),
('Pizza Quatro Queijos(massa, queijo)',1000,1000,1000,getdate())


create table tb_vendas 
(
	id_produto int identity,
	Produto varchar(1000),
	quantidade_vendida int,
	data_ultima_att datetime
)


create table historico_venda
(
	id_produto int identity,
	Produto varchar(1000),
	quantidade_vendida int,
	data_ultima_att datetime
)


select *from tb_produto
select *from tb_vendas
select *from historico_venda



create trigger trg_Administracao_de_vendas
on tb_vendas
for insert
as begin

	
    declare @produto varchar(100),
            @data datetime,
            @quantidade int

		     select @quantidade = quantidade_vendida, @data =data_ultima_att,
            @produto = Produto from inserted

			 update tb_produto set
                contagem_caixas_G = contagem_caixas_G - @quantidade,
                data_ultima_att = @data where Produto = @produto

            insert historico_venda
            values(@produto,@quantidade,@data)
    end

    insert tb_vendas values('Pizza Calabresa (massa,molho de tomate, calabresa)',80,getdate())