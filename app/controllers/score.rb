SerenityPadrino::Serenity.controllers :score do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/' do
  #   'Hello world!'
  # end

  layout :data

   get :getdata, :map => '/data' do

    stories = Story.all.order(:score)
    @story_neg = stories.first
    @story_pos = stories.reverse.first

        render 'getdata'
  end
  

end
