
def doRecordedat (h, line)
  index = line.index ("recorded_at\":\"")
  key = line[index+14,20]
  #"recorded_at":"2017-01-13T10:58:26Z",
  if h.has_key? key
    h[key] += 1
  else
    h[key] = 1
  end
end

dirname = "./mobiledevices/"
dd = Dir.new(dirname)

assetHash = Hash.new()

dd.each() do |fileName|
  if (fileName.index(".json"))
    p fileName
    fName = dirname + fileName
    p fName
    File.open(fName) do |f|
      p "start scan"+fName
      f.each("}}},") do |line|
        index = line.index ("asset\":\"")
        #"asset":"014256000011256",
        if (index != nil)
          key = line[index+8,15]
          if assetHash.has_key? key
            # there is
            recordedHash = assetHash[key]
            doRecordedat recordedHash, line
          else
            # a new asset
            recordedHash = Hash.new()
            doRecordedat recordedHash, line
            assetHash[key] = recordedHash
          end
        end
      end
    end
  end
  p assetHash.size
  output = File.new("./#{fileName}_morethan1rate.csv","w+")
  assetHash.each {|key, value|
    total = 0
    count = 0
    value.each {|key,value|
      if (value>1)
        count += value
      end
      total += value
    }
    output.puts "#{key}, #{count*100.00/total}"
  }
end

#writeSortedCSV



def writeSortedCSV
#p assetHash.keys
  assetHash.each {  |key, value|
    p "============="
    p key
    output = File.new("sort/"+key+".csv","w+")
    sorted = value.sort {|a,b| b[1]<=>a[1]}

    sorted.each  {|r|
      output.puts "#{r[0]},#{r[1]}"
    }
  }
end
