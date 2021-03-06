class Americanas < Ecommerce

	attr_accessor :id, :name, :price, :bank_price, :store_name

	def com_o_produto(id)
		@doc 	= acessar_site("http://www.americanas.com.br/produto/#{id}")
		self
	end

	def preco_venda
		valor_normal('span.price')
	end

	def preco_no_boleto
		valor_boleto('span.bankBill')
	end

	def descricao
		@doc.css('h1.title').first.content.strip
	end

	def valor_frete(cep)

		params = to_params({
			'codItemFusion'	=> @doc.css('input[name=codItemFusion]').first['value'],
			'postalCode' 	=> cep
		})

		doc 	= acessar_site("http://www.americanas.com.br/checkout/freightService.xhtml?#{params}")
		frete 	= JSON.parse(doc.css('body').first.content)['freightValue'].gsub(/[^\d]/, '')
		"#{frete[0..-3]}.#{frete[-2, 2]}".to_f
	end

end
