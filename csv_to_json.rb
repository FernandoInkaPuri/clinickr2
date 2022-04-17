require 'csv'

class CsvToJson
    def self.call(filename)
        data = CSV.read(filename, col_sep: ';')
        data.shift
        #tranformar array de array em array de hashs
        columns = %w[cpf name email birthday street_address city_address state_address
            doctor_crm doctor_crm_state doctor_name doctor_email result_token result_date test_type test_limits result]
          
        data.map do |row|
            row.each_with_object({}).with_index do |(elem, acc), idx|
                column_name = columns[idx]
                acc[column_name] = elem 
            end
        end
    end
end