module ProblemsHelper
  def problem_confirm(action)
    t('problems.confirm.%s' % action) unless Errbit::Config.confirm_err_actions.eql? false
  end

  def truncated_problem_message(problem)
    unless (msg = problem.message).blank?
      # Truncate & insert invisible chars so that firefox can emulate 'word-wrap: break-word' CSS rule
      truncate(msg.html_safe, length: 300).scan(/.{1,5}/).map { |s| h(s) }.join("&#8203;").html_safe
    end
  end

  def gravatar_tag(email, options = {})
    return nil unless email.present?

    options.reverse_merge!(s: 24)

    size = options[:s]
    options[:s] = options[:s] * 2 # for retina displays
    image_tag gravatar_url(email, options), alt: email, class: 'gravatar', width: size, height: size
  end

  def gravatar_url(email, options = {})
    return nil unless email.present?

    default_options = {
      d: Errbit::Config.gravatar_default,
    }
    options.reverse_merge! default_options
    params = options.extract!(:s, :d).delete_if { |k, v| v.blank? }
    email_hash = Digest::MD5.hexdigest(email)
    url = request.ssl? ? "https://secure.gravatar.com" : "http://www.gravatar.com"
    "#{url}/avatar/#{email_hash}?#{params.to_query}"
  end
end

