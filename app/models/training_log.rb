class TrainingLog < ApplicationRecord
  belongs_to :user
  validates :training_type, :weight, :reps, :sets, presence: true
end
