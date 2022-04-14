require 'sinatra'
require './csv_to_json'
require './search_patient'
configure do
    set port:3000
    set bind: '0.0.0.0'
end

get '/tests' do
    CsvToJson.call('result_tests.csv').to_json
end

get "/tests/:token" do
    #SearchPatient.search(params['token']).to_json
    all_result_tests = CsvToJson.call('result_tests.csv')
    selected = all_result_tests.select do |result_test|
        result_test['token_resultado_exame'] == params['token']
    end
    columns = %w[cpf nome_paciente email_paciente data_nascimento_paciente endereço_rua_paciente
        cidade_paciente estado_patiente crm_médico crm_médico_estado nome_médico email_médico
        token_resultado_exame data_exame tipo_exame limites_tipo_exame resultado_tipo_exame]
    result = selected.each_with_object({}) do |result_test, acc|
        #acc[column_name] = elem
        acc['token'] = result_test['token_resultado_exame']
        acc['date'] = result_test['data_exame']
        acc['cpf'] = result_test['cpf']
        acc['name'] = result_test['nome_paciente']
        acc['birthday'] = result_test['data_nascimento_paciente']
    
        acc['doctor'] = {
          'name' => result_test['nome_médico'],
          'crm' => result_test['crm_médico'],
          'crm_state' => result_test['crm_médico_estado']
        }
        acc['tests'] ||= []

        acc['tests'] << {
        'type' => result_test['tipo_exame'],
        'limits' => result_test['limites_tipo_exame'],
        'result' => result_test['resultado_tipo_exame']
        }
    end
    result.to_json
end