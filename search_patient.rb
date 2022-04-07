require 'csv'
require './csv_to_json'
class SearchPatient
    def self.search(token_exame)
        result = CsvToJson.call('result_tests.csv')   
        tests = result.find { |row| row['token_resultado_exame'] == token_exame } 
    end
end