require 'linkedin'

class LinkedInProfilesController < ApplicationController
  before_filter :authenticate_user!

  # GET /linked_in_profiles
  # GET /linked_in_profiles.json
  def index
    # get your api keys at https://www.linkedin.com/secure/developer
    client = LinkedIn::Client.new(ENV['LINKEDIN_API_KEY'], ENV['LINKEDIN_SECRET'])
    request_token = client.request_token :oauth_callback => url_for(:action => :new)
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret

    redirect_to client.request_token.authorize_url

  end

  # GET /linked_in_profiles/new
  # GET /linked_in_profiles/new.json
  def new
    client = LinkedIn::Client.new(ENV['LINKEDIN_API_KEY'], ENV['LINKEDIN_SECRET'])
    if session[:atoken].nil?
      pin = params[:oauth_verifier]
      atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
      session[:atoken] = atoken
      session[:asecret] = asecret
    else
      client.authorize_from_access(session[:atoken], session[:asecret])
    end

    @profile = client.profile
    @profile_fields = client.profile(:fields => %w(positions educations))

    current_user.import_profile_fields @profile_fields

    redirect_to resumes_path
  end
end
