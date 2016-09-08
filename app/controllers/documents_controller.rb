class DocumentsController < ApplicationController
	skip_before_filter :authenticate_user!
	def terms
	end
end
