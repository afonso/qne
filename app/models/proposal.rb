class Proposal < ActiveRecord::Base
  belongs_to :user
  belongs_to :demand

  def weekdays
    weekdays = []
    weekdays << "domingo" if self.sunday
    weekdays << "segunda" if self.monday
    weekdays << "terça" if self.tuesday
    weekdays << "quarta" if self.wednesday
    weekdays << "quinta" if self.thursday
    weekdays << "sexta" if self.friday
    weekdays << "sábado" if self.saturday
    weekdays
  end
end
