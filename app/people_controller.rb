require 'Date'

class PeopleController

  FORMATS = {
  	dollar_format: '$',
  	percent_format: '%'
  }

  ORDER = %i[first_name city birthdate]


  def initialize(params)
    @params = params
  end

  def normalize
  	return if @params&.empty?

  	data = []
  	normalized_data = []
  	metadata = {}

	@params.each do |k, v|
	  unless v.is_a?(String)
	  	metadata[k] = v
	  	next
	  end
	  
	  headers = []
      rows = v.split("\n")
      
      rows.each do |row|
      	row_data = row.split(FORMATS[k]).map { |ele| ele.strip }
      	if headers.empty?
		  headers += row_data
		  next
	    end

	    row_hash = {}
	    headers.each_with_index do |header, idx|
	      row_hash[header.to_sym] = row_data[idx]
	    end
	    
	    data << row_hash
      end
	end

	# sort by order
	data = data.sort_by {|elem| elem[metadata[:order]]}

	# get normalized data
	data.each do |row|
	  row_data = []
	  ORDER.each do |key|
	  	if key == :city
	  	  row_data << normalize_city(row[key])
  	  	elsif key == :birthdate
  	  	  row_data << normalize_date(row[key])
	  	else
	  	  row_data << row[key]
  		end
  	  end

  	  normalized_data << row_data.join(', ')
	end

	return normalized_data
  end

  private

  def normalize_city(city)
  	city_map = {
  	  'LA' => 'Los Angeles',
  	  'NYC' => 'New York City'
  	} 

  	city_map[city] || city
  end

  def normalize_date(date)
  	Date.parse(date).strftime('%-m/%-d/%Y')
  end

  attr_reader :params
end
