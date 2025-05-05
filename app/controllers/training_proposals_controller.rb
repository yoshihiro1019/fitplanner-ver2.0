class TrainingProposalsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def history
    
    @training_proposals = TrainingProposal.order(created_at: :desc)
    
  end
end
