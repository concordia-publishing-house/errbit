class ProblemDestroy
  attr_reader :problem

  def initialize(problem)
    @problem = problem
  end

  def execute
    Problem.transaction do
      delete_comments
      delete_errs
      problem.delete
    end
  end

  ##
  # Destroy all problem pass in args
  #
  # @params [ Array[Problem] ] problems the list of problem need to be delete
  #   can be a single Problem
  # @return [ Integer ]
  #   the number of problem destroy
  #
  def self.execute(problems)
    Array(problems).each do |problem|
      ProblemDestroy.new(problem).execute
    end.count
  end

private

  def errs_id
    @errs_id ||= problem.errs.all.pluck(:id)
  end

  def comments_id
    @comments_id ||= problem.comments.all.pluck(:id)
  end

  def delete_errs
    Notice.where(err_id: errs_id).delete_all
    Err.where(id: errs_id).delete_all
  end

  def delete_comments
    Comment.where(id: comments_id).delete_all
  end

end
