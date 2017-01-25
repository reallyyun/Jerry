
count = 0
limit = 3
filenumber = 1
dirname = "./mobiledevices/"
dd = Dir.new(dirname)
flag = true
outfile = File.new("00" , "w")

dd.each() do |fileName|
  if (fileName.index(".json"))
    p fileName
    if flag
      output = "output/#{fileName}_0000#{filenumber}.json"
      outfile = File.new(output,"w+")
      flag = false
    end
    fName = dirname + fileName
    p fName
    File.open(fName) do |f|
      p "start parse"
      f.each("}}},") do |line|
        count = count + 1
        if ((count == limit) && line[line.length-1].eql?(","))
          line = line[0,line.length-1] + "]"
        #  p line
        end

        outfile.puts(line)

        if (count == limit)
          filenumber = filenumber + 1
          str = ""
          if (filenumber<10)
            str = "0000"
          elsif filenumber<100 && filenumber>=10
            str = "000"
          elsif filenumber<1000 && filenumber>=100
            str = "00"
          elsif filenumber<10000 && filenumber>=1000
            str = "0"
          end
          output = "output/#{fileName}_#{str}#{filenumber}.json"
          outfile = File.new(output,"w+")
          flag = true
          count = 0
          outfile.print ("[")

        end
      end
    end
  end
end


