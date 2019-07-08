class TransfertsController < ApplicationController
  def index
    @transferts = Transfert.all
  end
end
