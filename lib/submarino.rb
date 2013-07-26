class Submarino < Ecommerce

	attr_accessor :id, :name, :price, :bank_price, :store_name

	def qual_preco_do_produto(id)

		doc	= acessar_site("http://www.submarino.com.br/produto/#{id}")

		if doc.css('strong span.amount').first.nil?
			produto_excluido
			exit
		end

		preco 	= doc.css('strong span.amount').first.content.gsub(/[^\d]/, '')
		boleto 	= doc.css('span.bankprice:not(.amount)').first.content.gsub(/[^\d]/, '')[0.. -3]
		boleto  = "#{boleto[0..2]}.#{boleto[3, 2]}".to_f
		preco  	= "#{preco[0..2]}.#{preco[3, 2]}".to_f

		@id 			= id
		@name			= doc.css('h1').first.content.strip
		@price			= preco
		@bank_price 	= boleto
		@store_name		= "submarino"
		
		compara_preco
		self
	end

end
