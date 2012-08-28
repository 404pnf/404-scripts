a = [3,6,1,2,4,2,1,2,3,4,3,2,1,2,3,4]

def uniq arr
  r = []
  while arr.size !=0 do
    current = arr.shift
    r << current
    if arr.include?(current)
      arr.delete(current)
    end
  end
  r
end

def uniq2 arr
  r = []
  while arr.size !=0 do
    current = arr.shift
    r << current
    arr.delete(current) # no need to use include, just delete it
  end
  r
end

def uniq3 arr
  # manual iterate
  r = []
  while arr.size !=0 do 
    current = arr.shift
    r << current
    arr.each_with_index do |item,index|
      if current == item
        arr.delete(index)
      end
    end
  end
  r
end

def unix_uniq arr
  r = []
  first = arr.shift
  while arr.size !=0
    if first == arr.first
      arr.shift
      # if now arr is empyt, will not do the while loop, 
      #so the last time, variable first is lot; therefore we test the condition here.  
      # comment the following if..end and run unix_uniq [1,1,2,2,1,1]
      # the result will be [1,2], which is incorrect.  The last 1 is lost
      if arr.size == 0 
        r << first
      end
    else
      r << first
      first = arr.shift
      p "result is #{r}"
      p "first is #{first}"
    end
  end
  r
end

#p uniq a
#p uniq2 a
#p unix_uniq a
#p unix_uniq([1,1,2,2,1,1])
p uniq3 a

     
