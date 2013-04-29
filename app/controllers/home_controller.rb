class HomeController < ApplicationController
  before_filter :set_variables, :only => [:random]
  before_filter :set_defaultquestions, :only => [:random]

  private
  def set_variables
    @setspath = "app/assets/images/sets/"
    @sets = Dir.glob(@setspath + "*").map { |f| f.split('/').last }
  end

  def set_defaultquestions
    @default_questions =  [ {
      :q => "First question, yes or no?",
      :a => ["Yes", "No"],
      :s => "alert(grabText(this))",
      }, {
      :q => "Second question, check it:",
      :a => ["Yes", "No", "Maybe"],
      :t => CHECKBOX,
      }, {
      :q => "Third question, tell me more:",
      :a => [""],
      :t => TEXTBOX,
      } ]
  end

  public
  def index
    session[:starttime] = Time.now
  end

  def random
    if not params[:complete] or params[:complete].length < @sets.length
      @set = @sets.sample
      if params[:complete]
        while params[:complete].include?(@set.to_s)
          @set = @sets.sample
        end
      end
      @images = Dir.glob(@setspath + @set.to_s + "/*.jpg").sort
      @description = File.read(@setspath + @set.to_s + "/description.html")
      respond_to do |format|
        format.html # next.html.erb
      end
    else
      redirect_to :action => :complete
    end
  end

  def complete
    reset_session
  end

end
