class RepositoriesController < ApplicationController
  def index
    binding.pry
    github = GithubService.new(access_hash = {access_token: session[:token]})
    @repos_array = github.get_repos
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos_array = JSON.parse(response.body)
  end

  def create
    # github = GithubService.new(session[:token])
    # github.create_repo(params[:name])
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
