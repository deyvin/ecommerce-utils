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

@americanas = Americanas.new
p @americanas.com_o_produto("113891760").valor_frete('28300000')
