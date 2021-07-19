arr = [1,2,3,4,5,6,7]
arr2 = ["a", "b", "c", "last"]
hash = {
    :dollars => 500,
    :crypto => 600
    }



#Create #my_each, a method that is identical to #each but (obviously) does not use #each. 
#You’ll need to use a yield statement. Make sure it returns the same thing as #each as well.
module Enumerable
    def my_each
        #self is the array
        i = 0
        while i<self.length
            if Hash === self
                yield self.keys[i], self.values[i]
                    i = i+1
            else
            yield self[i]
            i = i+1
            end
        end
        return self

    end

#p (arr.my_each{|item| puts item}) ===(arr.each{|item| puts item})
#=> true

#Create #my_each_with_index in the same way.
    def my_each_with_index
        i=0
        while i<self.length
            yield self[i] , i
            
            i = i+1
            
        end
        return self

    end


#      
#=>true

#Create #my_select in the same way, though you may use #my_each in your definition (but not #each).
    def my_select
        i=0
        output_array = []
        output_hash = {}
        while i<self.length 
            if Array === self 
            yield self[i]

                if yield self[i]
                    output_array.push(self[i])
                end
            elsif Hash === self
                    yield self.values[i]
                    
                    
                    if yield self.values[i] 
                        
                        output_hash[self.keys[i]]=self.values[i]
                        
                    end
                       
             end

            i = i+1
            
        end
        if Array === self
        output_array
        elsif Hash === self
            output_hash
        end
    end


#Create #my_all? (continue as above)
    def my_all?

        i = 0
        true_elements = 0

        while i<self.length
            yield self[i]
                if yield self[i]
                    true_elements = true_elements+1

               
                end
           i = i+1
        end
        if true_elements == self.length

            return true
        else
            false
        end
    end

#Create #my_any?
def my_any?

    i = 0
    true_elements = 0

    while i<self.length
        yield self[i]
            if yield self[i]
                true_elements = true_elements+1

           
            end
       i = i+1
    end
    if true_elements > 0

        return true
    else
        false
    end
end
#Create #my_none?
def my_none?

    i = 0


    while i<self.length
        yield self[i]
            if yield self[i]
               return false

           
            end
       i = i+1
    end
    

        return true
    
    
end
#Create #my_count

def my_count
        i = 0
        true_elements = 0
    
        while i<self.length
            yield self[i]
                if yield self[i]
                    true_elements = true_elements+1
    
               
                end
           i = i+1
        end
        true_elements
    
end
#Create #my_map

def my_map(&block)
    i = 0
    new_array = []
    while i<self.length
      
        new_array[i] = block.call(self[i])
        
        i = i+1
    
    end
    new_array
end
#Create #my_inject
def my_inject(&block)
    #gives 2 arguments; left enumerator, right to be added
    i = 1

    if Integer === self[i]

        enumerator=self[0]
        
    elsif String === self[i]
        enumerator=""
    end

    while i<self.length

      
       enumerator = block.call(enumerator, self[i])
        i=i+1
    end
    enumerator
end

#Test your #my_inject by creating a method called #multiply_els which multiplies all the elements of the array together by using #my_inject, e.g. multiply_els([2,4,5]) #=> 40
    
#Modify your #my_map method to take a proc instead.
    def my_map_proc(proc)
        i = 0
        new_array = []
        while i<self.length
          
            new_array[i] = proc.call(self[i])
            
            i = i+1
        
        end
        new_array
    end

    def my_map_any(arg=nil)
        if Proc === arg
                i = 0
            new_array = []
            while i<self.length
            
                new_array[i] = arg.call(self[i])
                
                i = i+1
            
            end
            new_array
        elsif block_given?
           
            i = 0
            new_array = []
            while i<self.length
            
                new_array[i] = yield self[i]
                
                i = i+1
            
            end
            new_array
        end
    end
#Modify your #my_map method to take either a proc or a block. It won’t be necessary to apply both a proc and a block in the same 
#my_map call since you could get the same effect by chaining together one #my_map call with the block and one with the proc. 
#This approach is also clearer, since the user doesn’t have to remember whether the proc or block will be run first. 
#So if both a proc and a block are given, only execute the proc.
end
p "each"
p hash.each {|k,v| puts "#{k} is #{v}"}
p "vs"
p hash.my_each {|k,v| puts "#{k} is #{v}"}

p "each with index"
puts (arr.each_with_index{|item,index| puts "#{item} at #{index}"}) === (arr.my_each_with_index{|item,index| puts "#{item} at #{index}"})
  p "select"
p hash.select{|k,v| v > 501}
p "vs"
p hash.my_select{|v| v > 501}

p ".all?"
p arr.all?{|item| item >0}
p arr.all?{|item| item >1}
p " vs"
p arr.my_all?{|item| item >0}
p arr.my_all?{|item| item >1}

p ".any?"
p arr.any?{|item| item ==5}
p arr.any?{|item| item >800}
p " vs"
p arr.my_any?{|item| item ==5}
p arr.my_any?{|item| item >800}
    

p ".none?"
p arr.none?{|item| item ==50}
p arr.none?{|item| item >0}
p " vs"
p arr.my_none?{|item| item ==50}
p arr.my_none?{|item| item >0}

p "count"
p arr.count{|item| item ==50}
p arr.count{|item| item >1}
p " vs"
p arr.my_count{|item| item ==50}
p arr.my_count{|item| item >1}

p "map"
p arr.map{|item| item * 2}
p arr2.map{|item| item + ", mapped!"}
p "vs"
p arr.my_map{|item| item * 2}
p arr2.my_map{|item| item + ", mapped!"}

p "inject"
p arr.inject{ |sum, n| sum + n }
p arr.inject{ |sum, n| sum - n }
p arr2.inject{ |sum, n| sum + n }
p "vs"
p arr.my_inject{ |sum, n| sum + n }
p arr.my_inject{ |sum, n| sum - n }
p arr2.my_inject{ |sum, n| sum + n }

def multiply_els(array)
    p "multiply_els"
    p array.my_inject{|enum, item| enum * item}
 end

multiply_els([2,4,5])

p "my_map_proc"
map = Proc.new{|item| item + 2}
p arr.my_map_proc(map)

p "proc || block"
p arr.my_map_any(map)
p "vs"
p arr.my_map_any{|item| item + 2}