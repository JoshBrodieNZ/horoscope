require 'sinatra'
require 'marky_markov'

zodiacs = %w(aquarius aries cancer capricorn gemini leo libra pisces sagittarius scorpio taurus virgo)

dictionaries = {}

zodiacs.each do |zodiac|
  dictionaries[zodiac] = MarkyMarkov::Dictionary.new("dictionaries/#{zodiac}")
end

get '/:zodiac' do
  @zodiac = params[:zodiac]
  @content = dictionaries[@zodiac].generate_5_sentences if zodiacs.include? @zodiac
  @image = 'https://unsplash.it/g/800/600?blur&random'
  erb :index
end