local input,endWeightsHidden,endWeightsOutput,weightsHidden,weightsOutput,hiddenD = {},{},{},{},{},{} --declaration of arrays
local deltaOutput, deltaHidden, gradientHidden, gradientOutput, sum1,zOut = {},{},{},{},{},{}         --declaration of arrays
local file = io.open('output.txt','w')                                    --writes the output in output.txt
learningRate, momentum, errorPrev, iterate = 0.01, 0.06, 0, 0              --initialize values for variables
hiddenNode = 10                                                            --no. of Hidden Nodes(to be changed)
			
for i=1, hiddenNode do                                                     --random connection weights to hidden layer
      weightsHidden[i],deltaHidden[i],endWeightsHidden[i] = {},{},{}
      for j=0,10 do                                                        --weightHidden[i][0]-->weight for bias x0
         weightsHidden[i][j] = string.format("%0.5f",math.random())
      end
end

math.randomseed( os.time() )
for i = 0, hiddenNode do  --random connection weights to output layer // weightsOutput[0] ->weight for bias z0
   weightsOutput[i] = string.format("%0.5f",math.random())
end 

while iterate < 3 do
   iter, times = 1, 0
   deltaOutput[0] = 0
   for i = 1, hiddenNode do                                          --initialize delta array equal to 0
      deltaOutput[i] = 0
      for j = 0, 10 do
         deltaHidden[i][j] = 0
      end   
   end
   --------------------------------TRAINING--------------------------------------
	while times < 100 and iter <= 1000 do
		err = 0                                                        --initialize value of error to 0
      if iterate == 0 then                                           --opens training, validation and test set
         fileOpen1  = assert(io.open("Input/Neural Nets/training.txt", "r"))
         fileOpen2  = assert(io.open("Input/Neural Nets/validation.txt", "r"))
         fileOpen3  = assert(io.open("Input/Neural Nets/test.txt", "r"))
      elseif iterate == 1 then
         fileOpen1  = assert(io.open("Input/Neural Nets/training1.txt", "r"))
         fileOpen2  = assert(io.open("Input/Neural Nets/validation1.txt", "r"))
         fileOpen3  = assert(io.open("Input/Neural Nets/test1.txt", "r"))
      else 
         fileOpen1  = assert(io.open("Input/Neural Nets/training2.txt", "r"))
         fileOpen2  = assert(io.open("Input/Neural Nets/validation2.txt", "r"))
         fileOpen3  = assert(io.open("Input/Neural Nets/test2.txt", "r"))
      end

		gradientOutput[0] = 0                                           --initialize gradient array equal to 0
		for i = 1, hiddenNode do
         gradientHidden[i],gradientOutput[i] = {},0
         for j = 0, 10 do
            gradientHidden[i][j] = 0
         end
      end
      
      for line in fileOpen1:lines() do                                --reads each line in fileOpen1/training set
         sum2 = weightsOutput[0]
        	for i = 1, hiddenNode do
        		column, sum1[i] = 0, weightsHidden[i][0]
           	for n in line:gmatch'%S+' do
           		column = column+1
              	if column < 11 then
                	input[column] = tonumber(n)
                 	sum1[i] = (weightsHidden[i][column]*tonumber(n))+ sum1[i]      --computes for the weighted sum of inputs to hidden
              	else 
                 	column11 = tonumber(n)            
              	end
           	end
           	zOut[i] = (1/(1+math.exp(-sum1[i])))                        ----computes for the weighted sum of hidden to output
           	sum2 = sum2 + (weightsOutput[i]*zOut[i])
        	end

         output = 1/(1+math.exp(-sum2))                                 --computes for output
	      diff = column11-output                                         --difference of predicted output from target output
         err = (diff^2)/2 + err                                         --computes for training error

	      outputD = diff*output*(1-output)                               ------computing for gradient
         gradientOutput[0] = outputD + gradientOutput[0]
	      for i = 1, hiddenNode do
            hiddenD[i] = zOut[i]*(1-zOut[i])*weightsOutput[i]*outputD
            gradientHidden[i][0] = hiddenD[i] + gradientHidden[i][0]
	         for j = 1, 10 do
               gradientHidden[i][j] = input[j]*hiddenD[i] + gradientHidden[i][j]
            end
            gradientOutput[i] = (zOut[i]*outputD) + gradientOutput[i]
         end
      end      
      fileOpen1:close()                                                 --closes the training set file
      
   -----------------------------------------VALIDATION---------------------------------------------
      errV = 0
      for line in fileOpen2:lines() do                                  --reads each line in fileOpen2/validation set
         sum2V = weightsOutput[0]
         for i = 1, hiddenNode do
            column, sum1[i] = 0, weightsHidden[i][0] 
            for n in line:gmatch'%S+' do
            	column = column+1
                if column < 11 then
                	sum1[i] = (weightsHidden[i][column]*tonumber(n))+ sum1[i]    --computes for the weighted sum of inputs to hidden
                else 
                	column11 = tonumber(n)            
                end
            end
            zOut[i] = (1/(1+math.exp(-sum1[i])))                        --computes for the weighted sum of hidden to output
            sum2V = sum2V + (weightsOutput[i]*zOut[i])
         end
         output = string.format("%0.8f",1/(1+math.exp(-sum2V)))         --computes for output
         errV = (((column11-output)^2)/2) + errV                        --computes for validation error
      end
      fileOpen2:close()                                                 --closes the validation set file

      if iter == 1 then                --------------saves the weights of epoch with the smallest validation error 
         cmp, times = errV, 0
         endWeightsOutput[0] = weightsOutput[0]
         for i = 1, hiddenNode do
            endWeightsOutput[i] = weightsOutput[i]
            for j = 0, 10 do
               endWeightsHidden[i][j] = weightsHidden[i][j]
            end
         end
      else 
         if errorPrev <= errV then times = times + 1 
         else
           if cmp > errV then
              times, cmp = 0, errV
              endWeightsOutput[0] = weightsOutput[0]
              for i = 1, hiddenNode do
                  endWeightsOutput[i] = weightsOutput[i]
                  for j = 0, 10 do
                     endWeightsHidden[i][j] = weightsHidden[i][j]
                  end
              end
            else 
               times = 0
            end
         end
      end                  
      errorPrev = errV
   -----------------------------------BACK PROPAGATION -----------------------------------------
      deltaOutput[0] = (learningRate * gradientOutput[0]) + (momentum * deltaOutput[0]) 
      weightsOutput[0] = weightsOutput[0] + deltaOutput[0]
      for i = 1, hiddenNode do
         for j = 0, 10 do 
            deltaHidden[i][j] = (learningRate * gradientHidden[i][j]) + (momentum * deltaHidden[i][j]) 
            weightsHidden[i][j] = weightsHidden[i][j]+ deltaHidden[i][j]
         end
         deltaOutput[i] = learningRate * gradientOutput[i] + (momentum * deltaOutput[i])                    
         weightsOutput[i] = weightsOutput[i] + deltaOutput[i]
      end

      print(iter, times,err,errV)
      iter = iter + 1
   end
   --------------------------------------TEST---------------------------------------------------
   errT,TP,FP,FN,TN = 0, 0, 0, 0, 0

   for line in fileOpen3:lines() do                                  --reads each line in fileOpen3/test set
      sum2V = endWeightsOutput[0] 
      for i = 1, hiddenNode do
         column,sum1[i] = 0,endWeightsHidden[i][0]
         for n in line:gmatch'%S+' do
         	column = column+1
            if column < 11 then
            	sum1[i] = (endWeightsHidden[i][column]*tonumber(n))+ sum1[i]     --computes for the weighted sum of inputs to hidden
            else 
            	column11 = tonumber(n)            
            end
         end
         zOut[i] = (1/(1+math.exp(-sum1[i])))                        --computes for the weighted sum of hidden to output
         sum2V = sum2V + (endWeightsOutput[i]*zOut[i])
      end
      output = string.format("%0.8f",1/(1+math.exp(-sum2V)))         --computes for output
      errT = (((column11-output)^2)/2) + errT

   --*****************classify output values if TP, FP, FN, TN ******************--
   if iterate == 2 then
      if tonumber(output) >= 0.5 and column11 == 1 then                             
         TP = TP + 1                                                                   
      elseif tonumber(output) >= 0.5 and column11 == 0 then
         FP = FP + 1
      elseif tonumber(output) < 0.5 and column11 == 0 then
         TN = TN + 1
      else
         FN = FN + 1
      end
   end 
   --*************************************************************************--
   end
   print("\n")
   fileOpen3:close()                                                  --closes test set file  

   weightsOutput[0] = endWeightsOutput[0]                             --use values of endWeights for next iteration
   for i = 1, hiddenNode do
      weightsOutput[i] = endWeightsOutput[i]
      for j = 0, 10 do
         weightsHidden[i][j] = endWeightsHidden[i][j]
      end
   end
   iterate = iterate + 1
end

print("Test Error \t", errT)
print("TP = "..TP,"\tFP = "..FP,"\tTN = "..TN,"\tFN = "..FN,"\n")        --computes for ROC measures
file:write("TP = ",TP,"\tFP = ",FP,"\tTN = ",TN,"\tFN = ",FN,"\n")
TPR = TP/(TP+FN)
FPR = FP/(FP+TN)
ACC = (TP + TN)/(TP + FN + FP + TN)
SPC = 1-FPR
print(TPR,FPR,ACC,SPC,"\n")
file:write("\nTPR = ",TPR," FPR = ",FPR," ACC = ", ACC," SPC = ",SPC,"\n")
