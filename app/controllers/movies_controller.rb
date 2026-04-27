class MoviesController < ApplicationController
  def index
    @sort_by = params[:sort_by]
    if @sort_by == 'title' || @sort_by == 'release_date'
      @movies = Movie.order(@sort_by)
    else
      @movies = Movie.all
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: 'Filme criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to movie_path(@movie), notice: 'Filme atualizado.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Movie.find(params[:id]).destroy
    redirect_to movies_path, notice: 'Filme removido.'
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
