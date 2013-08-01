#ecoding: utf-8
class Miniinthebox < Ecommerce

	attr_accessor :id, :name, :price, :bank_price, :store_name

	def qual_preco_do_produto(id)

		doc 	= acessar_site("http://www.miniinthebox.com/pt/descricao-2_p#{id}.html")

		#if doc.css("a.price").first.nil?
		#	produto_excluido
		#	exit
		#end

		preco 	= doc.css('a.price').first.content.gsub(/[^\d]/, '')
		p preco  	= "#{preco[0..-3]}.#{preco[3, 2]}"

		#boleto 	= doc.css('a.price').first.content#.gsub(/[^\d]/, '')
		#boleto  = "#{boleto[0..2]}.#{boleto[3, 2]}".to_f

		#@id 			= id
		#@name 			= doc.css('div.w-prodTitle h1').first.content.strip
		#@price 			= preco
		#@bank_price 	= boleto
		#@store_name 	= "Miniinthebox"
	
		#compara_preco
		#self
	end

end
