require 'digest/md5'

class Fingerprint
  
  def self.generate(notice)
    normalized_backtrace = notice.read_attribute(:backtrace)[0...3].map do |trace|
      trace.merge 'method' => trace['method'].gsub(/[0-9_]{10,}+/, "__FRAGMENT__")
    end
    
    Digest::MD5.hexdigest(normalized_backtrace.to_s)
  end
  
end
