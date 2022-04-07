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
    SearchPatient.search(params['token']).to_json
end