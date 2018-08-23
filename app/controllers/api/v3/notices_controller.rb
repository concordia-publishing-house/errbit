class Api::V3::NoticesController < ApplicationController

  UNKNOWN_API_KEY = "Your API key is unknown".freeze

  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  respond_to :json

  def create
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Headers"] = "origin, content-type, accept"
    return render(status: 200, text: "") if request.method == "OPTIONS"

    merged_params = params.permit(:key, :project_id, :notifier, :environment, :session, :context, :errors).to_h
    merged_params.merge!(JSON.parse(request.raw_post)) unless request.raw_post.empty?
    merged_params["key"] = request.headers["X-Airbrake-Token"] if request.headers["X-Airbrake-Token"]
    merged_params["key"] = authorization_token if authorization_token
    report = AirbrakeApi::V3::NoticeParser.new(merged_params).report

    return render plain: UNKNOWN_API_KEY, status: 422 unless report.valid?

    report.generate_notice!
    render status: 201, json: {
      id:  report.notice.id.to_s,
      url: app_problem_url(report.problem.app, report.problem)
    }
  rescue AirbrakeApi::ParamsError
    render plain: "Invalid request", status: 400
  end

private

  def authorization_token
    request.headers["Authorization"].to_s[/Bearer (.+)/, 1]
  end

end
