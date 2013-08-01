class Ecommerce
	attr_accessor :id, :name, :price, :bank_price, :con

	def acessar_site(url)
		Nokogiri::HTML(open(url, :proxy_http_basic_authentication => ['http://192.168.254.200:8080', 'deyvin', 'fdcsistemas123'] ))
	end
	
	def valor_normal(css_rule)
		preco 	= @doc.css(css_rule).first.content.gsub(/[^\d]/, '')
		"#{preco[0..-3]}.#{preco[-2, 2]}".to_f
	end

	def valor_boleto(css_rule)
		if @doc.css(css_rule).first.nil?
			return preco_venda
		end

		boleto 	= @doc.css(css_rule).first.content.gsub(/[^\d]/, '')
		"#{boleto[0..-3]}.#{boleto[3, 2]}".to_f
	end
end
