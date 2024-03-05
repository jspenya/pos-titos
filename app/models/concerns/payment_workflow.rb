module PaymentWorkflow
  extend ActiveSupport::Concern

  included do
    include Workflow

    workflow do
      state :pending do
        event :process, :transitions_to => :processing
      end

      state :processing do
        event :compelte, :transitions_to => :completed
      end

      state :completed
    end
  end
end
