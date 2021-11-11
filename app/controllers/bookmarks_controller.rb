class BookmarksController < ApplicationController

  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    ## associate a list
    @bookmark.list = @list

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to @list, notice: "bookmark was successfully created." }
        format.json { render :show, status: :created, location: @bookmark }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list)
  end

  private


  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end


end
