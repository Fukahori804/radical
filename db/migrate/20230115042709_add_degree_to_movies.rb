class AddDegreeToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :degree, :integer
  end
end
