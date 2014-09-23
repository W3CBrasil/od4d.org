# Scaffolding generated by Casein v5.0.0.0

module Casein
  class PostsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::AdminUser access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = 'Posts'
  		@posts = Post.order(pub_date: :desc).paginate :page => params[:page]
    end
  
    def show
      @casein_page_title = 'View post'
      @post = Post.find params[:id]
      @post_sections = PostSection.order(sort_order(:name))
    end
  
    def new
      @casein_page_title = 'Add a new post'
      @post = Post.new
      @post_sections = PostSection.order(sort_order(:name))
    end

    def create
      @post = Post.new post_params
    
      if @post.save
        articleDAO = ArticleDAO.new(Fuseki.new, FusekiJSONParser.new)
        articleDAO.insert(@post.attributes)
        flash[:notice] = 'Post created'
        redirect_to casein_posts_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new post'
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = 'Update post'
      
      @post = Post.find params[:id]
    
      if @post.update_attributes post_params
        articleDAO = ArticleDAO.new(Fuseki.new, FusekiJSONParser.new)
        articleDAO.update(@post.attributes)
        flash[:notice] = 'Post has been updated'
        redirect_to casein_posts_path
      else
        flash.now[:warning] = 'There were problems when trying to update this post'
        render :action => :show
      end
    end
 
    def destroy
      @post = Post.find params[:id]

      @post.destroy
      articleDAO = ArticleDAO.new(Fuseki.new, FusekiJSONParser.new)
      articleDAO.delete(@post.attributes)
      flash[:notice] = 'Post has been deleted'
      redirect_to casein_posts_path
    end
  
    private
      
      def post_params
        params.require(:post).permit(:title, :author, :pub_date, :content, :about, :post_sections_id)
      end

  end
end