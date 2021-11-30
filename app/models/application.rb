class Application < ApplicationRecord
  belongs_to :camp
  belongs_to :user

  def update_progress(wizard_steps, step)
    if wizard_steps.any? && wizard_steps.index(step).present?
      self.progress = ((wizard_steps.index(step) + 3).to_d / wizard_steps.count.to_d) * 100
      self.save
    else
      self.progress = 0
    end
  end
end