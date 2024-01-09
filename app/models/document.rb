class Document < ApplicationRecord
    belongs_to :staff, class_name: 'AdminUser', foreign_key: 'staff_id'
    has_many_attached :files

    validates :staff_id, :document_type, presence:true

    enum document_type: {
    passport: 'Passport',
    national_id: 'National ID',
    driver_license: 'Driver License',
    education_certificate: 'Education Certificate',
    experience_letter: 'Experience Letter',
    adhar_card: 'Adhar Card',
    resume: 'Resume',
    pan_card: 'PAN Card',
    bank_pass_book: 'Bank Pass Book',
    graduation_degree: 'Graduation Degree',
    tenth_marksheet: '10th Marksheet',
    twelfth_marksheet: '12th Marksheet',
  }
end