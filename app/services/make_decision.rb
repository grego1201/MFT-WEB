# frozen_string_literal: true

class MakeDecision
  HEIGHT_DIFF_ERROR = -5

  def initialize(params)
    @fencer1 = initialize_fencer(params[:fencer1])
    @fencer2 = initialize_fencer(params[:fencer2])
  end

  def obtain_decision
    experience = obtain_experience
    distance = obtain_distance
    agressiveness = obtain_agressiveness(experience)
    short_distance = short_distance?(distance, agressiveness)
    blade = short_distance
    second_intention = second_intention?(short_distance, experience)
    {
      agressiveness: agressiveness,
      short_distance: short_distance,
      blade: blade,
      second_intention: second_intention
    }
  end

  private

  def initialize_fencer(fencer_options)
    {
      age: fencer_options[:age].to_i,
      intimidated: fencer_options[:intimidated].to_i,
      height: fencer_options[:height].to_i,
      grip: fencer_options[:grip]
    }
  end

  def obtain_experience
    age1 = @fencer1[:age]
    age2 = @fencer2[:age]

    if @fencer2[:intimidated]
      return 0 if age1 > age2

      1
    else
      return 1 if age1 < age2

      2
    end
  end

  def obtain_distance
    height_difference = @fencer1[:height] - @fencer2[:height]
    grip_distance = obtain_grip_distance
    distance = calculate_distance(grip_distance, height_difference)

    distance
  end

  def calculate_distance(grip_distance, height_difference)
    if height_difference > HEIGHT_DIFF_ERROR
      calculate_higher(grip_distance)
    elsif height_difference < HEIGHT_DIFF_ERROR * -1
      calculate_lower(grip_distance)
    else
      grip_distance
    end
  end

  def calculate_higher(grip_distance)
    case grip_distance
    when 0 || 1
      0
    when 2
      1
    end
  end

  def calculate_lower(grip_distance)
    case grip_distance
    when 0
      1
    when 1 || 2
      2
    end
  end

  def obtain_grip_distance
    grip1 = @fencer1[:grip]
    grip2 = @fencer2[:grip]

    return 1 if grip1 == grip2
    return 0 if grip1 == 'French'

    2
  end

  def obtain_agressiveness(experience)
    return true if experience.zero?

    false
  end

  def short_distance?(distance, agressiveness)
    return false if [1, 2].include?(distance)

    agressiveness
  end

  def second_intention?(short_distance, experience)
    return false if short_distance
    return true if experience.zero?

    false
  end
end
