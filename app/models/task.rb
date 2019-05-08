class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  
  scope :search_title, ->(title) {
    return if title.blank? 
    where("title like ?","%#{title}%")
  }
  scope :search_status, ->(status) {
    return if status.blank?
    where(status: status)
  }
  scope :sort_expired, -> (sort_expired) { 
    order(deadline: "ASC") 
  }
  # scope :search_task, -> (title,status,sort_expired) do
  #   if title.present? && status.present? 
  #     where("title like ?","%#{title}%").where(status: status)
  #   elsif title.present? && status == ""
  #     where("title like ?","%#{title}%")
  #   elsif title == "" && status.present? 
  #     where(status: status)
  #     #enumでintegerでdbにあるのでstatusキーで値を取得する記載。
  #   elsif sort_expired.present?
  #     order(deadline: "ASC")
  #   else 
  #     order(created_at: "DESC") 
  #   end
  # end
  
  enum status: {"": 0 ,未着手: 1, 着手中: 2, 完了: 3 }
end
  

