require 'digest/md5'

class Fingerprint
  
  def self.generate(notice)
    normalized_backtrace = notice.read_attribute(:backtrace)[0...3].map do |trace|
      trace.merge 'method' => trace['method'].gsub(/[0-9_]{10,}+/, "__FRAGMENT__")
    end
    
    error_class = notice.error_class
    component = notice.component || 'unknown'
    action = notice.action
    environment = notice.environment_name || 'development'
    backtrace_only_fingerprint = Digest::MD5.hexdigest(normalized_backtrace.to_s)
    
    fingerprint = [error_class, component, action, environment, backtrace_only_fingerprint]
    Digest::MD5.hexdigest(fingerprint.join(","))
  end
  
end
