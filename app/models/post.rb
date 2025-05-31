class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }

  belongs_to :user

  mount_uploaders :images, ImageUploader

  # 検索対象の属性を明示する
  def self.ransackable_attributes(auth_object = nil)
    %w[title address body]
  end

  # 検索に使うアソシエーションを明示する
  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end
end
