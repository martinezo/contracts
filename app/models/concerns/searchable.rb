module Searchable
    extend ActiveSupport::Concern

    module ClassMethods
     
        def search_b(search,fields)
            if fields.nil? || fields.size < 1
		all
		else
                #where fields.map(|f| "search LIKE :codigo or unam_stock_number LIKE :codigo",{:codigo => "%#{params[:codigo]}%"}).paginate(page: params[:page], per_page: 2)
		where search.map{|f| "translate(lower(#{f}),'áéíóúàèìòù','aeiouaeiou') LIKE translate(lower('%#{fields}%'),'áéíóúàèìòù','aeiouaeiou')"}.join ' OR '
#		where search.map{|f| "#{f} LIKE '%#{fields}%'"}.join ' OR '
            end
        end
      end
end
