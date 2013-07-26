#ecoding: utf-8
class Extra < Ecommerce

	attr_accessor :id, :name, :price, :bank_price, :store_name

	def qual_preco_do_produto(id)

		doc 	= acessar_site("http://extra.com.br/Moveis/SaladeEstar/SofasePoltronas/Sofa-#{id}.html")

		if doc.css('#ctl00_Conteudo_ctl02_spanPrecoPor .price').first.nil?
			produto_excluido
			exit
		end

		preco 	= doc.css('#ctl00_Conteudo_ctl02_spanPrecoPor .price').first.content.gsub(/[^\d]/, '')
		preco  	= "#{preco[0..2]}.#{preco[3, 2]}".to_f

		boleto 	= doc.css('.boxFormasD span strong').first.content.gsub(/[^\d]/, '')
		boleto  = "#{boleto[0..2]}.#{boleto[3, 2]}".to_f

		@id 			= id
		@name 			= doc.css('h1').first.content.strip
		@price 			= preco
		@bank_price 	= boleto
		@store_name 	= "Extra"
	
		compara_preco
		self
	end

end
