require 'rails_helper'

TEST_CASE_1_EXPECTED_RESULTS = {
  :agressiveness=>false,
  :short_distance=>false,
  :blade=>false,
  :second_intention=>false
}

describe MakeDecision do
  # Test cases can check at documentation
  # grip 1 -> french

  it 'Test case 1' do
    fencer1 = create(:fencer, def_fencer_atrs(false, 18, 160, 1))
    fencer2 = create(:fencer, def_fencer_atrs(false, 30, 170, 1))

    results = MakeDecision.new(fencers_to_params(fencer1, fencer2)).obtain_decision
    expect(results).to eq(TEST_CASE_1_EXPECTED_RESULTS)
  end

  private

  def fencers_to_params(fencer1, fencer2)
   {
      :fencer1=> {
        :age=> fencer1.age.to_s,
        :intimidated=> fencer1.intimidated ? 1 : 0,
        :height=> fencer1.height.to_s,
        :grip=> fencer1.grip ? "french" : "anatomic"
      },
      :fencer2=>{
        :age=> fencer2.age.to_s,
        :intimidated=> fencer2.intimidated ? 1 : 0,
        :height=> fencer2.height.to_s,
        :grip=> fencer2.grip ? "french" : "anatomic"
      }
    }
  end

  def def_fencer_atrs(intimidated, age, height, grip)
    {
      intimidated: intimidated,
      age: age,
      height: height,
      grip: grip
    }
  end

end
