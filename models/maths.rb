def average(sequence)  
  sequence.inject(:+).to_f / sequence.length  
end  
