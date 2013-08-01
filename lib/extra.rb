#ecoding: utf-8
class Extra < Ecommerce

	attr_accessor :id, :name, :price, :bank_price, :store_name


	def com_o_produto(id)
		@doc 	= acessar_site("http://extra.com.br/Moveis/SaladeEstar/SofasePoltronas/Sofa-#{id}.html")
		@id 	= id
		self
	end

	def preco_venda
		valor_normal('#ctl00_Conteudo_ctl02_spanPrecoPor .price')
	end

	def preco_no_boleto
		valor_boleto('#ctl00_Conteudo_ctl50_pnlDescontoFormaPagamento div div div span strong')
	end

	def descricao
		@doc.css('h1').first.content.strip
	end

	def valor_frete(cep)

		cep 		= cep.split("-")
		proxy_addr 	= '192.168.254.200'
    	proxy_port 	= 8080

		uri = URI('http://www.extra.com.br/AsyncProduto.ashx')
		res = Net::HTTP::Proxy(proxy_addr, proxy_port, 'deyvin', 'fdcsistemas123').post_form(uri, 'prefixo' => cep[0], 'sufixo' => cep[1], 'idLojista' => 15, 'sku' => @id)
		frete = JSON.parse(res.body).first["PrecoFrete"].gsub(/[^\d]/, '')

		"#{frete[0..-3]}.#{frete[-2, 2]}".to_f

	end

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
