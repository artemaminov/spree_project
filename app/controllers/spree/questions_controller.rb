# frozen_string_literal: true

module Spree
  class QuestionsController < StoreController
    def create
      @form_id = params[:form_id] || 'form_send_call'
      @message = 'Спасибо наш менеджер вам позвонит'

      begin
        Spree::Question.create!(permitted_params)
        @form_id = params[:form_id]
      rescue StandardError
        @message = 'Возникла ошибка при запросе'
      end
    end

    private

    def permitted_params
      params.require(:question).permit(:name, :phone)
    end
  end
end
