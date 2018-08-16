class RefingerprintErrs < ActiveRecord::Migration[4.2]
  def up
    require "refingerprint_errs"
    RefingerprintErrs.execute
  end

  def down
  end
end
