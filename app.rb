require 'nokogiri'
require 'open-uri'
require 'mysql2'
require './lib/ecommerce'
require './lib/americanas'
require './lib/extra'
require './lib/ricardoeletro'
require './lib/submarino'

extra = Extra.new
p extra.qual_preco_do_produto(301551).bank_price
