class TrainingLog < ApplicationRecord
  belongs_to :user
  validates :training_type, :weight, :reps, :sets, presence: true
  validates :day_of_week, presence: true, inclusion: { in: %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday] }
end
