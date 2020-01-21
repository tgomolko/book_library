require_dependency("create")

class CreatePlan
  include Interactor

  delegate :plan_params, :product_stripe_id, to: :context

  def call
    @stripe_plan = Stripe::Plans::Create.new(plan_params, product_stripe_id).call

    context.plan = Plan.create!(build_plan_params)

    rescue ActiveRecord::ActiveRecordError, Stripe::StripeError  => error
      rollback if error.kind_of?(ActiveRecord::ActiveRecordError)
      context.fail!(message: error.message)
  end

  private

  def rollback
    Stripe::Plans::Destroy.new(@stripe_plan.id).call if @stripe_plan.id
  end

  def build_plan_params
    plan_params.merge(stripe_id: @stripe_plan.id)
  end
end
