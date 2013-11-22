# A Role is a relationship between an Actor and a Movie.
# 
# === To make a new Role, do this
#
#   @actor = Actor.create( ... )
#   @movie = Movie.create( ... )
#   role_params = {:as => 'Captain Haddock'}
#   @role = @actor.roles_rels.connect(@movie, role_params)
#   @role.save
#
class Contain < Neo4j::Rails::Relationship


end
