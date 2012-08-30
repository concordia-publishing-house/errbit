class UpdateFingerprintOfErrs < Mongoid::Migration
  def self.up
    Err.all.each do |err|
      error_class = err["error_class"]
      component = err["component"]
      action = err["action"]
      environment = err["environment"]
      backtrace_only_fingerprint = err["fingerprint"]
      
      fingerprint_components = [error_class, component, action, environment, backtrace_only_fingerprint]
      fingerprint = Digest::MD5.hexdigest(fingerprint_components.join(","))
      
      err["backtrace_only_fingerprint"] = backtrace_only_fingerprint
      err.fingerprint = fingerprint
      err.save(:validate => false)
    end
  end
  
  def self.down
    Err.each do |err|
      err.fingerprint = err["backtrace_only_fingerprint"]
      err.save(:validate => false)
    end
  end
end
