require 'rails_helper'

describe MakeDecision do

  let(:test_cases_data) { JSON.parse(File.open('spec/services/make_decision_test_cases_data').read) }

  it 'Test case 1' do
    expect(prepare_test_case(test_cases_data['tc1'])).to be_truthy
  end

  it 'Test case 2' do
    expect(prepare_test_case(test_cases_data['tc2'])).to be_truthy
  end

  it 'Test case 3' do
    expect(prepare_test_case(test_cases_data['tc3'])).to be_truthy
  end

  it 'Test case 4' do
    expect(prepare_test_case(test_cases_data['tc4'])).to be_truthy
  end

  private

  def prepare_test_case(tc_data)
    fencer1 = create(:fencer, tc_data['fencer1'])
    fencer2 = create(:fencer, tc_data['fencer2'])

    results = MakeDecision.new(fencers_to_params(fencer1, fencer2)).obtain_decision
    results == tc_data['results'].symbolize_keys
  end

  def fencers_to_params(fencer1, fencer2)
    {
      fencer1: {
        age: fencer1.age.to_s,
        intimidated: fencer1.intimidated ? 1 : 0,
        height: fencer1.height.to_s,
        grip: fencer1.grip == 1 ? 'french' : 'anatomic',
        ranking: fencer1.ranking,
        handness: fencer1.handness,
        weapon: fencer1.weapon
      },
      fencer2: {
        age: fencer2.age.to_s,
        intimidated: fencer2.intimidated ? 1 : 0,
        height: fencer2.height.to_s,
        grip: fencer2.grip == 1 ? 'french' : 'anatomic',
        ranking: fencer2.ranking,
        handness: fencer2.handness,
        weapon: fencer2.weapon
      }
    }
  end
end
