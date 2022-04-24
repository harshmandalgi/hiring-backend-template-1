require './app/people_helper.rb'

class PeopleController
  include PeopleHelper

  def initialize(params)
    @params = params
  end

  def normalize
  	return if @params&.empty?

  	data_parser = DataParser.new(@params)
  	data = data_parser.parse
  	metadata = data_parser.metadata

	normalize_data(data, metadata)
  end

  private

  attr_reader :params
end
