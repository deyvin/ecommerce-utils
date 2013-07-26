class Ecommerce
	attr_accessor :id, :name, :price, :bank_price, :con
	@@con = Mysql2::Client.new(:host => 'localhost', :username => 'root', :password => '1234', :database => 'ecommerce')

	def acessar_site(url)
		Nokogiri::HTML(open(url, :proxy_http_basic_authentication => ['http://192.168.254.200:8080', 'deyvin', 'fdcsistemas123'] ))
	end

	def grava_banco
		@@con.query "INSERT INTO PRODUTOS (CODE, ECOMMERCE, NOME, PRECO) \
						VALUES (#{@id}, '#{store_name}', '#{@name.gsub('"', '')}', '#{@bank_price}')"
	end
	
	def atualiza_banco
		@@con.query  "UPDATE PRODUTOS SET PRECO = '#{@bank_price}' WHERE CODE = #{@id}"
	end

	def compara_preco
		results = @@con.query "SELECT MAX(PRECO) PRECO FROM PRODUTOS WHERE CODE = '#{id}'"

		if !results.first['PRECO'].nil?				

			if results.first['PRECO'].round(2) < @bank_price
				atualiza_banco
				notificar "aumentou"
			elsif results.first['PRECO'].round(2) > @bank_price
				notificar "abaixou"
			else
				notificar "mesmo preco"
			end

		else
			grava_banco
			produto_excluido
		end
	end

	def notificar(info)
		if info == "abaixou"
			notificar_via_sms
		end
		`notify-send -i gtk-dialog-info -u normal "#{store_name} [#{info}]" "#{@name.gsub('"', '')} \n\n Preco: R$ #{@bank_price} (boletex)"`
	end

	def produto_excluido
		`notify-send -i gtk-dialog-info -u normal "#{store_name} [EXCLUIDO]" "#{@name.gsub('"', '')} \n\n"`
	end

	def notificar_via_sms

		msg 	= URI.encode("#{store_name} \n\n Abaixou o preco do #{@name.gsub('"', '')} \n\n Preco: R$ #{@bank_price} no boletex\n\n")
		url 	= "http://www.fsist.com.br/sms.aspx?tel=2298110095&msg=#{msg}"
		open 	= open(url, :proxy_http_basic_authentication => ['http://192.168.254.200:8080', 'deyvin', 'fdcsistemas123'] )
		doc 	= Nokogiri::HTML(open)

		doc.css("body").first.content
	end
end
