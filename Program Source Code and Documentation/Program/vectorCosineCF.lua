local file = io.open('predicted_cos.txt','w')
arr_v,train,test,train_sqrt,test_sqrt,avg,wuv,value,pai = {},{},{},{},{},{},{},{},{}	--declaration of arrays
min,max = {},{}
--------------determines the min and max per feature for normalization of data set values----------------
for i = 1,10 do
	min[i],max[i] = 0,0
end

for line in io.lines 'Input/trainCF.txt' do
	col = 0
	for n in line:gmatch'%S+' do
		col = col + 1
		if col < 11 then
			if tonumber(n) > max[col] then max[col] = tonumber(n)
			elseif tonumber(n) < min[col] then min[col] = tonumber(n) end
		end
	end
end

for line in io.lines 'Input/testCF.txt' do
	col = 0
	for n in line:gmatch'%S+' do
		col = col + 1
		if col < 11 then
			if tonumber(n) > max[col] then max[col] = tonumber(n)
			elseif tonumber(n) < min[col] then min[col] = tonumber(n) end
		end
	end
end
--------------------------------------------------------------------------------
------------------Collaborative Filtering computation--------------------
row = 1
for line in io.lines 'Input/trainCF.txt' do											--reads each line in 'train.txt'
	sum,col = 0,0
	train[row] = {}
	for n in line:gmatch'%S+' do
		col = col + 1
		if col < 11 then 
			train[row][col] = (tonumber(n)-min[col])/(max[col]-min[col])	--puts values of file in train[][]
			sum = sum + train[row][col]
		else 
			train[row][col] = tonumber(n) 
		end
	end

	average = sum/10														--gets the average per line/ row
	arr_v[row] = train[row][11]-average
	train_sqr = 0
	for i = 1, 10 do														--raises every value in train[][] to 2
		train_sqr = math.pow(train[row][i],2) + train_sqr
	end
	train_sqrt[row] = math.sqrt(train_sqr)									--square root of the squared value
	row = row + 1
end

row_test = 1
for line in io.lines 'Input/testCF.txt' do											--reads each line in 'test.txt'
	sum,col,test[row_test],test_sqr = 0,0,{},0
	for n in line:gmatch'%S+' do
		col = col + 1
		if col < 11 then 
			test[row_test][col] = (tonumber(n)-min[col])/(max[col]-min[col])	--puts the values to test[][] 
			sum = test[row_test][col] + sum
			test_sqr = math.pow(test[row_test][col],2) + test_sqr			--raises the values to 2
		else
			value[row_test] = tonumber(n)		 
		end
	end
	avg[row_test] = sum/10													--computes for the average per line/ row
	test_sqrt[row_test] = math.sqrt(test_sqr)								--square root of the squared value
	row_test = row_test + 1
end

TP,TN,FP,FN = 0,0,0,0
for i = 1, row_test-1 do
	sum_up, sum_weights,wuv[i] = 0,0,{}
	for j = 1, row-1 do
		sum = 0
		for k = 1, 10 do 													--dot product
			sum = (test[i][k]*train[j][k]) + sum 
		end					
		wuv[i][j] = sum/(train_sqrt[j] * test_sqrt[i])						--computes for similarity using Vector Cosine
		sum_up = (arr_v[j] * wuv[i][j]) + sum_up							--will be used in computation of output
		sum_weights = math.abs(wuv[i][j]) + sum_weights
	end

	pai[i] = avg[i] + (sum_up/sum_weights)									--computes for the output 
	print(pai[i]) 
	file:write(pai[i].."\n")

	if pai[i] < 0.5 and value[i] == 0 then 									--classify output if TN, FN, TP, FP
		TN = TN + 1
	elseif pai[i] < 0.5 and value[i] == 1 then 
		FN = FN + 1
	elseif pai[i] >= 0.5 and value[i] == 1 then 
		TP = TP + 1
	else 
		FP = FP + 1 
	end
end

-----------=------ROC Measures-----------------------
print("TP = "..TP,"FP = "..FP,"TN = "..TN,"FN = "..FN,"\n")
file:write("TP = ",TP,"\tFP = ",FP,"\tTN = ",TN,"\tFN = ",FN,"\n")
TPR = TP/(TP+FN)
FPR = FP/(FP+TN)
ACC = (TP + TN)/(TP + FN + FP + TN)
SPC = 1 - FPR
print("TPR "..TPR,"FPR "..FPR,"ACC "..ACC,"SPC "..SPC)
file:write("\nTPR = ",TPR," FPR = ",FPR," ACC = ", ACC,"SPC = ",SPC,"\n")