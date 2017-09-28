class Summary < ApplicationRecord
  GITHUB_API_URL="https://api.github.com"

  def user
    user_response
  end

  def repos
    repos_response.sort do |a, b|
      b["pushed_at"].to_date <=> a["pushed_at"].to_date
    end
  end

  def languages
    repos_response
      .map { |repo| repo["language"] }
      .reject { |lang| lang.blank? }
      .uniq
      .sort
      .join(", ")
  end

  def get_user
    url = "#{GITHUB_API_URL}/users/#{username}"
    self.user_response = authenticated_get(url)
  end

  def get_repos
    url = "#{GITHUB_API_URL}/users/#{username}/repos"
    response = authenticated_get(url)
    self.repos_response = response.to_a
  end

  def authenticated_get(url)
    HTTParty.get(url, headers: {
      "Authorization": "token #{ENV["GITHUB_PERSONAL_ACCESS_TOKEN"]}",
      "User-Agent": "edilsonh"
      })
  end

  def ready?
    user_response.present? && repos_response.present?
  end

end
