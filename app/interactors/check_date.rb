class CheckDate
  include Interactor

  def call
    if context.a > context.b
      context.success!
    else
      context.fail!
    end
  end
end
