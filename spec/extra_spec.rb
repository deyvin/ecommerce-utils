#encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper.rb'


describe Extra do

	before(:each) do
		@extra 	= Extra.new
		@produto_caro	= 1947760 #TV Slim LED 40" Full HD Samsung
		@produto_barato = 194784 #Livro - Meu Livro - Não Pegue Este Livro
	end
  
	it "Ao solicitar um valor normal deveria retornar um tipo Float" do
		@extra.com_o_produto(@produto_caro).preco_venda.class.should == Float
	end

	it "Deveria retornar um valor maior que zero" do
		@extra.com_o_produto(@produto_caro).preco_venda.should > 0
	end

	it "Ao solicitar o preço no boleto deveria retornar um tipo FLoat" do
		@extra.com_o_produto(@produto_caro).preco_no_boleto.class.should == Float
	end

	it "Ao solicitar o preço no boleto deveria retornar um valor maior que zero" do
		@extra.com_o_produto(@produto_caro).preco_no_boleto.should > 0
	end


	it "Um produto sem desconto no boleto deveria retornar um tipo Float" do
		@extra.com_o_produto(@produto_barato).preco_no_boleto.class.should == Float
	end

	it "Um produto sem desconto no boleto deveria retornar um valor maior que zero" do
		@extra.com_o_produto(@produto_barato).preco_no_boleto.should > 0
	end

	it "Deveria retornar a descricao do produto" do
		@extra.com_o_produto(@produto_barato).descricao.should_not nil
	end

	it "Deveria retornar valor maior que zero" do
		@extra.com_o_produto(@produto_barato).valor_frete('28300-000').should > 0
	end

	it "Deveria retornar frete grátis 0.00" do
		@extra.com_o_produto(@produto_caro).valor_frete('28300-000').should == 0
	end

end
