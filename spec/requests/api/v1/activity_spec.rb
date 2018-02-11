RSpec.describe Api::V1::ActivityController, type: :request do
  let(:user) { FactoryBot.create(:user)}
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json'}.merge!(credentials) }
  before do
    7.times { FactoryBot.create(:entry, user: user, sentiment_list: 'Sad', created_at: Date.yesterday) }
    7.times { FactoryBot.create(:entry, user: user, created_at: Date.yesterday) }
    2.times { FactoryBot.create(:entry, user: user, created_at: Date.today.months_ago(2)) }
    2.times { FactoryBot.create(:entry, user: user, created_at: Date.today.months_ago(4)) }
    2.times { FactoryBot.create(:entry, user: user, created_at: Date.today.months_ago(12)) }
    FactoryBot.create(:entry, user: user, sentiment_list: 'Angry')
  end

  describe 'GET /v1/activity' do
    it 'returns entries for the past week and past six months' do
      get '/api/v1/activity', headers: headers
      expect(response.status).to eq 200
      expected_response = eval(file_fixture('entries_activity.txt').read)
      expect(response_json).to eq expected_response.as_json
    end
  end
end
