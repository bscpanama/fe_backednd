class ExpireAccountJob < ApplicationJob
  queue_as :default
  discard_on ActiveJob::DeserializationError

  def perform(user)
    user.account.update(status: "inactivo")
  end
end
