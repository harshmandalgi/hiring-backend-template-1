class DataParser

  attr_reader :metadata

  FORMATS = {
  	dollar_format: '$',
  	percent_format: '%'
  }

  def initialize(params)
    @params = params
    @metadata = {}
  end

  def parse
  	data = []
  	normalized_data = []

	@params.each do |k, v|
	  unless v.is_a?(String)
	  	@metadata[k] = v
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

	data
  end
end