class Americanas < Ecommerce

	attr_accessor :id, :name, :price, :bank_price, :store_name

	def qual_preco_do_produto(id)

		doc	= acessar_site("http://www.americanas.com.br/produto/#{id}")

		if doc.css('p.sale span.price').first.nil?
			produto_excluido
			exit
		end

		preco 	= doc.css('p.sale span.price').first.content.gsub(/[^\d]/, '')
		boleto 	= doc.css('span.bankBill').first.content.gsub(/[^\d]/, '')[0.. -3]
		boleto  = "#{boleto[0..2]}.#{boleto[3, 2]}".to_f
		preco  	= "#{preco[0..2]}.#{preco[3, 2]}".to_f

		@id 			= id
		@name			= doc.css('h1.title').first.content.strip
		@price			= preco
		@bank_price 	= boleto
		@store_name		= "americanas"

		compara_preco
		self
	end

end
