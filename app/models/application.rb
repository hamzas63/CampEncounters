class Application < ApplicationRecord
  belongs_to :camp
  belongs_to :user

  has_rich_text :medicine

  def update_progress(wizard_steps, step)
    if wizard_steps.any? && wizard_steps.index(step).present?
      self.progress = ((wizard_steps.index(step) + 3).to_d / wizard_steps.count.to_d) * 100
      self.save
    else
      self.progress = 0
    end
  end

  def check_progress
    self.progress == 100
  end

  def last_step
    self.progress == 91
  end
end
