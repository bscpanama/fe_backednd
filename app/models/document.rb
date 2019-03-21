class Document < ApplicationRecord
  belongs_to :user

  enum status: {
    activo: "activo",
    inactivo: "inactivo"
  }

  has_one_attached :documento_xml
  has_one_attached :qr_code
  scope :by_status, -> status { where(status: status) }
  scope :by_date, -> fecha_de_emision { where(fecha_de_emision: fecha_de_emision) }
  scope :by_period, -> started_at, ended_at { where(fecha_de_emision: started_at..ended_at) }
  scope :by_days, -> days { where(fecha_de_emision: Date.today..days.to_i.days.from_now) }

  validates :documento_xml, blob: { content_type: ['text/xml', 'application/xml'], size_range: 1..2.megabytes }
  validates :qr_code, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..2.megabytes }

end
