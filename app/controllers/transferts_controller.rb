class TransfertsController < ApplicationController
  def index
    @transferts = Transfert.order("created_at DESC")

    if params[:query].present?
      if params[:query][:league].present?
        @transferts = @transferts.filter_by_league(params[:query][:league])
      end

      if params[:query][:search].present?
        @transferts = @transferts.global_search(params[:query][:search])
      end
    end
  end

end
