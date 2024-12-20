class TrainingLog < ApplicationRecord
  belongs_to :user
  validates :training_type, presence: true
  validates :weight, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :reps, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :sets, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :day_of_week, presence: true, inclusion: { in: %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday] }
end
