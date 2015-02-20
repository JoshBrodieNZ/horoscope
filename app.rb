require 'sinatra'
require 'marky_markov'

require 'erubis'
set :erb, :escape_html => true

zodiacs = %w(aquarius aries cancer capricorn gemini leo libra pisces sagittarius scorpio taurus virgo)

dictionaries = {}

zodiacs.each do |zodiac|
  dictionaries[zodiac] = MarkyMarkov::Dictionary.new("dictionaries/#{zodiac}")
end

get '/:zodiac' do
  @zodiac = params[:zodiac]
  if zodiacs.include? @zodiac
    @content = dictionaries[@zodiac].generate_5_sentences 
    @image = 'https://unsplash.it/g/800/600?blur&random'
  erb :index
end