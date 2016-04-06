class Information < ActiveRecord::Base
  belongs_to :user
  belongs_to :city
  belongs_to :state
  belongs_to :school
  validates :school_id, presence: {message: "Você precisa digitar o nome da escola e depois clicar na escola na listagem que aparece abaixo, se sua escola não for encontrada, nos mande uma mensagem no fale conosco."}, if: :expected_finish
end
