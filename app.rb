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
  else
    @zodiac = "Please select a zodiac"
    @content = "Valid options are 'aquarius', 'aries', 'cancer', 'capricorn', 'gemini', 'leo', 'libra', 'pisces', 'sagittarius', 'scorpio', 'taurus' or 'virgo'"
  end
  erb :index
end