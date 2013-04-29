class Question < ActiveRecord::Base
  attr_accessible :answer, :ip, :question, :set, :set_id, :starttime
end
