class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(hash)
        @id = hash[:id]
        @name = hash[:name]
        @type = hash[:type]
        @db = hash[:db]
    end

    def self.save(name, type, db)
        sql = <<-SQL
                INSERT INTO pokemon (name, type)
                VALUES (?, ?);
                SQL
        
        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon
            WHERE id = ?
            LIMIT 1;
            SQL

        pokemon = db.execute(sql, id)
          .map{|row| Pokemon.new({id:row[0], name:row[1], type:row[2], db:db})}[0]

    end

end
