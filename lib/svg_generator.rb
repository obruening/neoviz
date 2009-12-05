class SVGGenerator
  SVG_FILENAME = "#{RAILS_ROOT}/public/images/neo4j/output.svg"
  
  def create_image(person_nodes, opts = {})
    g = GraphViz::new("G", :bgcolor => '#EDF5FF')

    Neo4j::Transaction.run do
      nodes_hash = Hash.new

      person_nodes.each do |person|
        color = 'black'
        color = 'red' if (opts[:persons_to_highlight] || []).include?(person)
        color = 'blue' if person == opts[:root_person]

        nodes_hash[person.name] = g.add_node(person.name, :color => color, :fillcolor => 'white', :style => 'filled')
      end

      person_nodes.each do |person|
        person.friends.each do |friend|
          g.add_edge(nodes_hash[person.name], nodes_hash[friend.name])
        end
      end
    end

    g.output( :svg => SVG_FILENAME, :use => "dot")
  end


  def image_height(width)
    file = File.new(SVG_FILENAME)
    doc = REXML::Document.new(file)
    doc.root.attributes['height'].to_i * width / doc.root.attributes['width'].to_i
  end

end
