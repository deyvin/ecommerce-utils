require 'nokogiri'
require 'open-uri'
require 'mysql2'
require 'json'
require './lib/ecommerce'
require './lib/americanas'
require './lib/extra'
require './lib/ricardoeletro'
require './lib/submarino'
require './lib/miniinthebox'

#extra = Extra.new
#p extra.qual_preco_do_produto(76171).bank_price

@extra = Extra.new
p @extra.com_o_produto("194784").valor_frete('28300-000')
