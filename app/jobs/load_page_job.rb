class LoadPageJob < ApplicationJob
  queue_as :default

  def perform(id)
    summary = Summary.find(id)

    if !summary.ready
      summary.get_repos
      summary.get_user
    end

    summary.save
  end

end
