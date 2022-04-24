module PeopleHelper

  ORDER = %i[first_name city birthdate]

  def normalize_data(data, metadata)
    normalized_data = []

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

    normalized_data
  end

  def normalize_date(date)
  	Date.parse(date).strftime('%-m/%-d/%Y')
  end

  private

  def normalize_city(city)
  	city_map = {
  	  'LA' => 'Los Angeles',
  	  'NYC' => 'New York City'
  	} 

  	city_map[city] || city
  end
end