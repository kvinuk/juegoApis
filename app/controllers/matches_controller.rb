class MatchesController < ApplicationController
	before_action :authenticate_user!
	before_action :check_belong_user!, only: [:show]

	def show
		min_id = params[:min_id]
		@users = @match.users.order("id ASC")
		@difference = nil


			while @match.questions.count < 10 do
				questionId = rand(15) + 1
				if @match.questions.include?(Question.find(questionId))
				else
					@match.questions << Question.find(questionId)
				end
			end
			if @match.questions.count < 11
				@match.questions << Question.find(31)
			else
			end
		questions = @match.questions.order("id ASC")
		if min_id
		  @question = questions.where("question_id > ?", min_id).first
		else
		  @question = questions.first
		end

		if params[:val] != nil #checa que el usuario haya dado una respuesta
			if Question.find(min_id).answer1 == params[:val] #compara la respuesta del usuario con la respuesta correcta
				#suma score
				current_user.score+=10
				current_user.save
				@difference = "+ 10"
			else
				@difference = "+ 0"
			end
		else
			
		end

		@users.each do |user| 
			if @match.score < user.score
				@match.score = user.score
				@match.save
				if @match.winner == nil && user.score == 50
				@match.winner = user.id
				@match.save
				else
				end
			else
			end


		end

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
				current_user.save
			else
			end
			if !current_user.matches.exists?(id: @match.id)
					current_user.matches << @match
					current_user.save
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
  			if current_user.active == nil
  				redirect_to new_match_path
  			else
  				if current_user.active != @match.id
  					redirect_to "/matches/#{current_user.active}"
  				else

  				end
  			end
  		end
  	end
end
