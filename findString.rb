dirname = "./test/"

keyWords = "jerry"
output = "./output.txt"

dd = Dir.new(dirname)
outfile = File.new(output,"w+")

dd.each() do |fileName|
  if (fileName.index(".txt"))
    p fileName
    filename = dirname + fileName

    outfile.puts "==========#{fileName}======="

    File.open(filename) do |f|
      f.each("\n") do |line|
        if (line.index(keyWords) != nil)
          outfile.puts(line)
        end

      end
    end
  end

end


outfile.close
