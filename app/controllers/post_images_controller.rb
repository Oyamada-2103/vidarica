class PostImagesController < ApplicationController

  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    # 上でだめなら下で
    # @post_image = current_user.post_images.new(post_params)
    tag_list = params[:post_image][:tag_name].split('・')
    @post_image.user_id = current_user.id

    if @post_image.save
      @post_image.save_tag(tag_list)
      redirect_to post_images_path
    else
      redirect_to post_image_path
    end
  end

  def index
    # タグ機能の実装
    @tag_list = Tag.all

    # @post_images = PostImage.all
    # ページ機能の追加
    @post_images = PostImage.page(params[:page]).per(3)#reverse_order
  end

  def show
    @post_image = PostImage.find(params[:id])
    # コメント機能の実装
    @post_comment = PostComment.new
    # タグ機能の実装
    @post_image_tags = @post_image.tags
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def update
    post_image = PostImage.find(params[:id])
    post_image.update(post_image_params)
    redirect_to post_image_path(post_image)
  end


  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    # @post_images = @tag.post_images.all
    @post_images = PostImage.page(params[:page]).reverse_order
  end

  private

  def post_image_params
    params.require(:post_image).permit(:image, :caption)
  end

end
