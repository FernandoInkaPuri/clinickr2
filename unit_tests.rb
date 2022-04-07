require 'test/unit'
require './csv_to_json'

def convert_array_to_hash(array)
    columns = %w[cpf name]
    array.each_with_object({}).with_index do |(elem, acc), idx|
        column_name = columns[idx]
        acc[column_name] = elem 
    end
end
class CsvToJsonTest < Test::Unit::TestCase
    def test_convert_array_to_hash
        row = ["048.108.026-04", "Juliana dos Reis Filho"]
        
        expectation = { 
            "cpf" => "048.108.026-04",
            "name" => "Juliana dos Reis Filho" 
        }

        assert_equal expectation, convert_array_to_hash(row)
        
    end
    def test_csv_to_hash
        #result = csv_to_hash
        result = CsvToJson.call('result_tests.csv')
        selected = result.find { |row| row['cpf'] == '048.108.026-04' } 
        assert_equal "Juliana dos Reis Filho", selected['nome_paciente']
    end
end