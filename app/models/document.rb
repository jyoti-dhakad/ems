class Document < ApplicationRecord
  belongs_to :staff, class_name: 'AdminUser', foreign_key: 'staff_id'
  has_many_attached :files

  validates :staff_id, :document_type, presence: true
  validate :validate_file_format
  validates_uniqueness_of :document_type, scope: :staff_id

  enum document_type: {
    Adhar_Card: 'Adhar Card',
    Bank_Pass_Book: 'Bank Pass Book',
    Education_Certificate: 'Education Certificate',
    Experience_Letter: 'Experience Letter',
    Graduation_Degree: 'Graduation Degree',
    PAN_Card: 'PAN Card',
    Passport: 'Passport',
    Photo: 'Photo',
    Resume: 'Resume',
    Tenth_Marksheet: '10th Marksheet',
    Twelfth_Marksheet: '12th Marksheet',
    Other: 'Other'
  }

  private

  def validate_file_format
    return unless files.attached?

    allowed_formats = %w(application/pdf image/jpeg image/png)

    files.each do |file|
      unless file.content_type.in?(allowed_formats)
        errors.add(:files, 'must be a valid PDF, JPEG, PNG, or Photo file')
      end
    end
  end
end
