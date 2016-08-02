def get_average(sequence)  
  sequence.inject(:+).to_f / sequence.length  
end  
