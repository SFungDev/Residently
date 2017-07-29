def hashToString(addressHash)
    #Check the validity of the hash and raises an error if invalid
    essential = ["street_line_1", "town_or_city", "postcode"]
    either = ["house_name", "house_number"]
    unless essential.all? {|k| addressHash.key? k} && either.any? {|k| addressHash.key? k}
        raise("Required key(s) missing")
    end

    #Fixed structure is safe from hash ordering and can be modified as needed
    structure = 
            [
            ["subpremise", "house_name"],
            ["house_number","street_line_1"],
            "street_line_2",
            "town_or_city",
            "region",
            "postcode"
            ]
    result = []

    #Build result line by line as defined by the fixed structure
    structure.each do |line|
        #If there are multiple elements in a line join them appropriately
        if line.respond_to?("each")
            lineString = []

            line.each do |key|
                if addressHash[key] != nil
                    lineString.push(addressHash[key])
                end
            end

            #Join the line into a string, only push if line is not empty
            if lineString.any?
                if line.include?("house_number")
                    lineString = lineString.join(" ")
                else
                    lineString = lineString.join(", ")
                end            
                result.push(lineString) 
            end
        
        #If only a single element in a line, push if present
        elsif addressHash[line] != nil
            result.push(addressHash[line])
        end       
    end
    
    #join all the lines together with correct new line symbols
    result = result.compact
    result = result.join(", \n")
    puts result
end
