
class Question < ActiveRecord::Base
  attr_accessible :body, :title, :user_id, :up_cache, :down_cache, :rank_value, :controversy_value, :official_id
  belongs_to :official
  belongs_to :user
  has_many :question_votes

  validates :user_id, presence: true
  validates :official_id, presence: true

  def calcRank
    if(updated_at != nil)
      time_val = Time.now - created_at
    else
      time_val = 10
    end

    rank_value = 12/Math.log(time_val) + (up_cache - down_cache)
    update_attributes(:rank_value => rank_value)
  end

  def calcControversy
    if(updated_at != nil)
      time_val = Time.now - created_at
      if(up_cache == 0 and down_cache == 0)
        controversy_value = 0
      else
        cval = ((up_cache + down_cache + 10).to_f/((up_cache - down_cache).abs+9) - 1).abs
        controversy_value = 1/Math.log(time_val).abs + cval
      end
    else
      controversy_value = 0
    end

    update_attributes(:controversy_value => controversy_value)
  end
end