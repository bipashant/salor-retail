class EmployeeLogin < ActiveRecord::Base
  belongs_to :employee
  belongs_to :vendor
  before_save :set_totals
  before_update :set_totals
  attr_accessible :amount_due, :hourly_rate, :login, :logout, :shift_seconds, :employee_id,:vendor_id
  def set_totals
    if self.logout then
      self.shift_seconds = (self.logout - self.login).to_i
    end
    if self.shift_seconds and self.hourly_rate then
      hours = (self.shift_seconds.to_f / 60 / 60)
      self.amount_due = hours * self.hourly_rate
    end
  end
  def login=(d)
    if d.class == String
      puts "Class is string"
      parts = d.scan(/(\d{4,4})\/(\d{2,2})\/(\d{2,2}) (\d{2,2}):(\d{2,2})/)
      t = Time.local(parts[0][0],parts[0][1],parts[0][2],parts[0][3],parts[0][4])
      puts t
      write_attribute :login, t
    else
      write_attribute :login,d
    end
  end
  def logout=(d)
    if d.class == String
      puts "Class is string"
      parts = d.scan(/(\d{4,4})\/(\d{2,2})\/(\d{2,2}) (\d{2,2}):(\d{2,2})/)
      t = Time.local(parts[0][0],parts[0][1],parts[0][2],parts[0][3],parts[0][4])
      puts t
      write_attribute :logout, t
    else
      write_attribute :logout,d
    end
  end
end
