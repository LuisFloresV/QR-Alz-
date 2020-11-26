# == Schema Information
#
# Table name: patients
#
#  id               :integer          not null, primary key
#  birth            :date
#  emergency_number :string
#  hexa_code        :string
#  m_lastname       :string
#  name             :string
#  p_lastname       :string
#  phase            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

30.times do
  Patient.create!([{
    name: Faker::TvShows::SouthPark.character,
    emergency_number: Faker::Number.number(digits: 10),
    m_lastname: Faker::Nation.nationality,
    phase: Faker::Number.between(from: 1, to: 4),
    p_lastname: Faker::Nation.language,
    birth: Faker::Date.between(from: '1940-09-23', to: '1980-09-25')
  }])
end