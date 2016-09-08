class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  before_action :set_hinshis, only: [:index,:search,:words_edit]
  before_action :check_commitment,only: [:words_test]
  before_action :check_role,except:[:fav,:index,:show,:words_test,:search,:help]
  # GET /words
  # GET /words.json
  def index
    @words = Word.all
    @words = @words.order(' page ASC')

    # @words = @words.where(id: current_user.words)

    # @selected_hinshis = @hinshis

    
    render 'index-printable' ,:layout => 'printable' if params[:printable] == 'true'
  end

  # GET /words/1
  # GET /words/1.json
  def show
  end

  # GET /words/new
  def new
    @word = Word.new
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(word_params)
    
    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render :show, status: :created, location: @word }
      else
        format.html { render :new }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  def words_edit
    @section = params[:section_no]
    @words = Word.where(section: @section)

    # sort by id and page
    @words = @words.order(' page ASC')
  end

  def view
    @from = params[:from]
    unless @from.in?(['pinnin','kantaiji','imi'])
      render text: "URLパラメータが存在しないか、不正です。from=pinnin | kantaiji | imi,[to=pinnin | kantaiji | imi]"
    end
    
    @to = params[:to]
    unless @to.in?(['pinnin','kantaiji','imi'])
      @to = 'all'
    end

    @section = params[:section_no]
    @words = Word.where(section: @section)
  end

  def words_test
    @words= Word.all
    

    @from = params[:from]
    unless @from.in?(['pinnin','kantaiji','imi'])
      render text: "URLパラメータが存在しないか、不正です。from=pinnin | kantaiji | imi,[to=pinnin | kantaiji | imi]"
    end
    
    @to = params[:to]
    unless @to.in?(['pinnin','kantaiji','imi'])
      @to = 'all'
    end

    @section = params[:section]
    if @section.nil?
      @section = (12..20).to_a
    end
    @words = @words.where(section: @section)

    @isonlyfav = params[:isonlyfav]
    if @isonlyfav == 'true'
      @words = @words.where(id: current_user.words)
    end

    # sort
    @words = @words.order(' page ASC')


    @doShuffle = params[:doshuffle]
    if @doShuffle == 'true'
      @words = @words.shuffle
    end

    render :layout => 'onsen'
  end

  def ajax_words_create
    logger.debug 'ajax!'
    @word = Word.new(word_params)
    
    if @word.save
      current_user.increment(:commitment)
      current_user.save
      render json: @word
      return
    else
      render json: @word.errors, status: :unprocessable_entity
      return
    end
  end

  def ajax_words_update
    @word = Word.find(ajax_word_params[:id])
    
    if @word.update(word_params)
      current_user.increment(:commitment)
      current_user.save
      render json: @word
      return
    else
      render json: @word.errors, status: :unprocessable_entity
      return
    end
  end

  def ajax_words_delete
    logger.debug 'delete!!!'
    @word = Word.find(ajax_word_params[:id])
    
    if @word.destroy
      render json: @word
      return
    else
      render json: @word.errors, status: :unprocessable_entity
      return
    end
  end

  def fav
    @id = params[:word][:id]
    word = Word.where(id: @id)
    # user = User.where(id: params[:user_id])
    user = current_user

    if user.words.exists? word
      user.words.destroy word
      @new_fav_link = '☆'
    else
      user.words << word
      @new_fav_link = '★'
    end
  end

  def help
  end


  # PATCH/PUT /words/1
  # PATCH/PUT /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url, notice: 'Word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    # TODO: エスケープ処理
    @query = params[:q]
    @words = Word.where("pinnin
     like(:qu) OR kantaiji like(:qu) OR imi like(:qu)",{qu: "%#{@query}%"})

    
    unless params[:hinshis].nil?
      @selected_hinshis = params[:hinshis][:value]
      @words = @words.where(hinshi: @selected_hinshis)
    end

    @isonlyfav = false
    unless params[:isonlyfav].nil?
      @isonlyfav = params[:isonlyfav]
      @words = @words.where(id: current_user.words)
    end

    @words = @words.order(' page ASC')


    if params[:printable] == 'true'
      render 'index-printable' ,:layout => 'printable' 
    else 
      render :index
    end      
    # render text: @words.size
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    def set_hinshis
      @selected_hinshis =[]
      @hinshis = ["noun","verb","adjective","adverb", "preposition","number","conjunction", "exclamation", "rigoushi","idiom", "auxiliary_verb","other","uncategorized"]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      # params.require(:word).permit(:pinnin, :kantaiji, :hinshi, :imi, :rigoushi, :page, :section)
      params.require(:word).permit(:pinnin,:styledpinnin,:rawpinnin, :kantaiji, :hinshi, :imi, :page, :section)
    end

    def ajax_word_params
      # params.require(:word).permit(:id,:pinnin, :kantaiji, :hinshi, :imi, :rigoushi, :page, :section)
      params.require(:word).permit(:id,:pinnin,:styledpinnin,:rawpinnin, :kantaiji, :hinshi, :imi, :page, :section)
    end

    # def word_id
    #   params.require(:word).permit(:id)
    # end
    def check_commitment
      @required_commitment = -1
      if current_user.commitment < @required_commitment
        render 'not-enough-commitment',:layout => 'onsen'
      end
    end

    def check_role
      unless (current_user.role == 'editor') || ( current_user.role == 'manager')
        raise Forbidden
      end
    end
end
