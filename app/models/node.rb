class Node < Neo4j::Rails::Model
  property :title

  has_n(:contains).to(Node).relationship(Contain)
end
