class CheckDate
  include Interactor

  def call
    if context.date1 > context.date2
      context.success!
    else
      context.fail!
    end
  end
end
