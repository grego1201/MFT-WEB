# frozen_string_literal: true

class MakeDecision
  HEIGHT_DIFF_ERROR = -5

  def initialize(params)
    @fencer1 = initialize_fencer(params[:fencer1])
    @fencer2 = initialize_fencer(params[:fencer2])
    @tableu = params[:tableu].to_i
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
      second_intention: second_intention,
      risk: risk
    }
  end

  private

  def initialize_fencer(fencer_options)
    {
      age: fencer_options[:age].to_i,
      intimidated: fencer_options[:intimidated].to_i,
      height: fencer_options[:height].to_i,
      grip: fencer_options[:grip],
      ranking: fencer_options[:ranking].to_i,
      handness: fencer_options[:handness].to_i,
      weapon: fencer_options[:weapon].to_i
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

  def risk
    predict = make_predict
    win_probability = predict.split('[').last.split(' ').first.to_f

    if win_probability > 0.75
      4
    elsif win_probability > 0.60
      3
    elsif win_probability > 0.50
      2
    elsif win_probability > 0.40
      1
    else
      0
    end
  end

  def make_predict
    uri = URI.parse('https://mftapi.herokuapp.com/predict/')
    request = Net::HTTP::Get.new(uri)
    request.set_form_data(predict_params)

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    response.body
  end

  def predict_params
    {}.tap do |request_params|
      2.times do |index|
        %w[age handness ranking weapon].each do |char|
          params_char = "fencer#{index + 1}_#{char}"
          request_params.merge!(params_char => instance_variable_get("@fencer#{index + 1}")[char.to_sym])
        end
      end
      request_params[:tableu] = @tableu
    end
  end
end
