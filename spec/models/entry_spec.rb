require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe 'DB Table' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :title }
    it { is_expected.to have_db_column :body }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :body }
    it { is_expected.to validate_presence_of :label_list }
    it { is_expected.to validate_presence_of :sentiment_list }
  end

  describe 'Relations' do
    it { is_expected.to have_many :labels }
    it { is_expected.to have_many :sentiments }
    it { is_expected.to belong_to :user}
  end

  describe FactoryBot do
    it 'should be valid' do
      expect(FactoryBot.create(:entry)).to be_valid
    end
  end
end
