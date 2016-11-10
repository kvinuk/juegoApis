class MatchesController < ApplicationController
	before_action :authenticate_user!
	before_action :check_belong_user!, only: [:show]

	def show
		@users = @match.users
	end
	def new
		@match = current_user.matches.build
	end

	def create
		@match = current_user.matches.build(match_params)
		@match.score = 0
		current_user.matches << @match
		current_user.score = 0
		current_user.save
		if @match.save
			current_user.active = @match.id
			current_user.save
			redirect_to @match
		else
			render :new
		end
	end

	def search

	end

	def join
		if @match = Match.where(title: match_params[:title]).first
			if current_user.active != @match.id
				current_user.active = @match.id
				current_user.score = 0
			else
			end
			if !current_user.matches.exists?(id: @match.id)
					current_user.matches << @match
			else
			end
			redirect_to "/matches/#{@match.id}"
		else
			redirect_to search_match_path
		end

	end

	def leave
		current_user.update(active: nil)
		redirect_to new_match_path
	end

	private

	def match_params
  		params.require(:match).permit(:title)
  	end

  	def check_belong_user!
  		@match = Match.find(params[:id])
  		if !@match.users.where(id: current_user.id).exists?
  			redirect_to search_match_path
  		else
  			if @match.winner != nil || current_user.active == nil
  				redirect_to new_match_path
  			else
  				if current_user.active != @match.id
  					redirect_to "/matches/#{current_user.active}"
  				else
  					redirect_to root
  				end
  			end
  		end
  	end
end
