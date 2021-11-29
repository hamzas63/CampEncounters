class CheckDate
  include Interactor

  def call
    if context.end_date > context.current_date
      context.success!
    else
      context.fail!
    end
  end
end
