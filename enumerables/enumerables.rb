# require "byebug"
class Array
    def my_each(&prc)
        i = 0 

        while i < self.length
            prc.call(self[i])
            i += 1
        end
        self
    end

    def my_select(&prc)
        selected = []
        # self.each { |num| selected << num if self.my_each(prc)}
        # return selected

        self.my_each do |num|
            selected << num if prc.call(num)
        end
        return selected
    end

    def my_reject(&prc)
        selected = []
        self.my_each do |ele|
            selected << ele if !prc.call(ele)
        end
        selected 
    end

    def my_any?(&prc)
        count = 0
        self.my_each do |ele|
            count += 1 if prc.call(ele)
        end
        count >= 1
    end

    def my_all?(&prc)
        count = 0
        self.my_each do |ele|
            count += 1 if prc.call(ele)
        end
        count == self.length
    end

    def my_flatten
        #base case 
        if !self.is_a?(Array) 
            return [self]
        end

        #recursive step 
        result = []

        self.each do |ele| 
            if ele.is_a?(Array)
                result += ele.my_flatten
            else
                result << ele
            end
        end

        result

    end

    def my_zip(*array)
        array.unshift(self)
        array.each do |arr|
            if arr.length <= self.length
                while arr.length < self.length
                    arr << nil
                end
            else
                while arr.length > self.length
                    arr.pop
                end
            end
        end
        array.transpose
    end

    def my_rotate(num=1)
        newArr = self.map {|ele| ele}
  
        if num >= 0
            num.times do 
                shifted = newArr.shift
                newArr.push(shifted)
                
            end
        else

            (-num).times do 
                popped = newArr.pop
                newArr.unshift(popped)
            end
        end
        newArr 
    end

    def my_join(sep="")
        newStr = ""
        (0..self.length - 1).each do |i|
            if i == self.length - 1
                newStr += self[-1]
            else
                newStr += self[i] + sep
            end
        end
        return newStr
    end

    def my_reverse
        result = [] 

        i = self.length - 1

        while i >= 0 
            result << self[i]
            i -= 1
        end
        result 
    end

end

# p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# p [ 1 ].my_reverse               #=> [1]


# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"


# a = [ "a", "b", "c", "d" ]

# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

# p [1, 2, 3].my_each{|num| num * 2}


# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []


# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true