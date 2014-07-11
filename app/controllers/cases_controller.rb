class CasesController < ApplicationController
  def index
    @practical_cases = CaseDAO.new.list_all_cases(request.original_url)
  end
end
