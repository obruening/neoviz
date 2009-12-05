class Friendship
  include Neo4j::RelationshipMixin

  property :since
end