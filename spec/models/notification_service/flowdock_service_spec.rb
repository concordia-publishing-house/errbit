require 'spec_helper'

describe NotificationServices::FlowdockService do
  let(:service) { Fabricate.build(:flowdock_notification_service) }
  let(:app) { Fabricate(:app, name: 'App #3') }
  let(:problem) { Fabricate(:notice, message: '<3', err: Fabricate(:err, problem: Fabricate(:problem, app: app))).problem }

  it 'sends message in appropriate format' do
    stub_request(:post, "https://api.flowdock.com/v1/messages/team_inbox/api-token").
       to_return(status: 200, body: "", headers: {})

    service.create_notification(problem)
  end
end
