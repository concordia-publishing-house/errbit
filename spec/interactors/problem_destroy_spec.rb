require 'spec_helper'

describe ProblemDestroy do
  let!(:problem) { Fabricate(:problem) }
  let!(:err_1) { Fabricate(:err, problem: problem) }
  let!(:err_2) { Fabricate(:err, problem: problem) }
  let!(:comment_1) { Fabricate(:comment, err: err_1) }
  let!(:comment_2) { Fabricate(:comment, err: err_2) }
  let!(:notice_1_1) { Fabricate(:notice, err: err_1) }
  let!(:notice_1_2) { Fabricate(:notice, err: err_1) }
  let!(:notice_2_1) { Fabricate(:notice, err: err_2) }
  let!(:notice_2_2) { Fabricate(:notice, err: err_2) }

  it 'should all destroy all errs, comments, and notices' do
    expected_timestamp = Time.new(2029, 11, 4, 14, 29, 13)
    Timecop.freeze(expected_timestamp) do
      ProblemDestroy.new(problem).execute
    end
    expect(Problem.where(id: problem.id).exists?).to eq(false)
    expect(Problem.with_deleted.where(id: problem.id).count).to eq(1)
    expect(Problem.with_deleted.find(problem.id).deleted_at).to eq(expected_timestamp)
    expect(Problem.with_deleted.find(problem.id).updated_at).to eq(expected_timestamp)
    expect(Err.where(id: err_1.id).exists?).to eq(false)
    expect(Err.where(id: err_2.id).exists?).to eq(false)
    expect(Comment.where(id: comment_1.id).exists?).to eq(false)
    expect(Comment.where(id: comment_2.id).exists?).to eq(false)
    expect(Notice.where(id: notice_1_1.id).exists?).to eq(false)
    expect(Notice.where(id: notice_1_2.id).exists?).to eq(false)
    expect(Notice.where(id: notice_2_1.id).exists?).to eq(false)
    expect(Notice.where(id: notice_2_2.id).exists?).to eq(false)
  end

end
