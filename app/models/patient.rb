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
class Patient < ApplicationRecord
  after_create :generate_qr
  has_one_attached :qr_code

  validates :name, presence: true, length: { minimum: 3 }
  validates :birth, presence: true, length: { minimum: 3 }
  validates :emergency_number, presence: true, length: { in: 3..10 }, uniqueness: { case_sensitive: false },numericality: { greater_than_or_equal_to: 1 }
  validates :m_lastname, presence: true, length: { minimum: 3 }
  validates :p_lastname, presence: true, length: { minimum: 3 }
  validates :phase, presence: true, length: { is: 1 }

  private 
  
  def generate_qr
    self.hexa_code = SecureRandom.hex
    save

    @qrcode = RQRCode::QRCode.new(self.hexa_code)

    png = @qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: 'black',
      file: nil,
      fill: 'white',
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 120
    )
    
    IO.binwrite("app/assets/images/qrcode#{self.hexa_code}.png", png.to_s)
    
    self.qr_code.attach(io: File.open("app/assets/images/qrcode#{self.hexa_code}.png"), filename: "qrcode#{self.hexa_code}.png")
  end

end
