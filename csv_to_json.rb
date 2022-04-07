require 'csv'

class CsvToJson
    def self.call(filename)
        data = CSV.read(filename, col_sep: ';')
        data.shift
        #tranformar array de array em array de hashs
        columns = %w[cpf nome_paciente email_paciente data_nascimento_paciente endereço_rua_paciente
            cidade_paciente estado_patiente crm_médico crm_médico_estado nome_médico email_médico
            token_resultado_exame data_exame tipo_exame limites_tipo_exame resultado_tipo_exame]
        data.map do |row|
            row.each_with_object({}).with_index do |(elem, acc), idx|
                column_name = columns[idx]
                acc[column_name] = elem 
            end
        end
    end
end