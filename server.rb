require 'sinatra'
require 'pg'
require './importer'

configure do
    set port: 3000
    set bind: '0.0.0.0'
end

connection = PG.connect(
    host: 'clinickpg',
    dbname: 'postgres',
    user: 'postgres',
    password: '123456'
)
  
get '/import/:filename' do
    initial_time = Time.now

    Importer.call(params['filename'])

    "Done in #{Time.now - initial_time} seconds"
end
  
get '/tests' do
    @a = connection.exec('SELECT * FROM result_tests').to_a.to_json
    
    @a
end

get "/tests/:token" do
    #SearchPatient.search(params['token']).to_json
    sql = %{
        SELECT * FROM result_tests WHERE result_token = $1
    }
      
    results = connection
        .exec_params(sql, [params['token']])
        .to_a
      
    columns = %w[cpf name email birthday street_address city_address state_address
        doctor_crm doctor_crm_state doctor_name doctor_email result_token result_date test_type test_limits result]
      
    result = results.each_with_object({}) do |result_test, acc|
        #acc[column_name] = elem
        acc['token'] = result_test['result_token']
        acc['date'] = result_test['result_date']
        acc['cpf'] = result_test['cpf']
        acc['name'] = result_test['name']
        acc['birthday'] = result_test['birthday']

        acc['doctor'] = {
            'name' => result_test['doctor_name'],
            'crm' => result_test['doctor_crm'],
            'crm_state' => result_test['doctor_crm_state']
        }
        acc['tests'] ||= []

        acc['tests'] << {
        'type' => result_test['test_type'],
        'limits' => result_test['test_limits'],
        'result' => result_test['result']
        }
    end
    result.to_json
end