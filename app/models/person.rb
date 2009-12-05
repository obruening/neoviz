class Person
  include Neo4j::NodeMixin

  property :name, :salary, :age
  index :name, :salary, :age

  has_n(:friends).to(Person).relationship(Friendship)

  def add_as_friend(person_id)
    @person_to_add_as_friend = Neo4j.load(person_id)
    friends << @person_to_add_as_friend
  end

  def delete_as_friend(person_id)
    @person_to_delete_as_friend = Neo4j.load(person_id)
    relationships[@person_to_delete_as_friend].delete if friends.include?(@person_to_delete_as_friend)
  end
end
