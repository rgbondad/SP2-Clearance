local file = io.open('predicted_userbased.txt','w')
train,test,arr_u,arr_v,wuv,avg,pai = {},{},{},{},{},{},{}				--declaration of arrays
min,max,value = {},{},{}
-----------determines the min and max per feature for normalization of data set values-------------
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
-------------------------------------------------------------------------
------------------Collaborative Filtering computation--------------------
row = 1
for line in io.lines 'Input/trainCF.txt' do										--reads each line in 'train.txt'
	avg_user,col = 0,0
	for n in line:gmatch'%S+' do
		col = col + 1
		if col < 11 then 
			train[col] = (tonumber(n)-min[col])/(max[col]-min[col])		--saves to train[] the value per feature
			avg_user = avg_user + train[col]
		else 
			train[col] = tonumber(n)
		end
	end

	avg_user = avg_user/10												--computes for average of each row/ line
	arr_v[row] = {}
	for i = 1, 11 do
		arr_v[row][i] = train[i]-avg_user
	end
	row = row + 1
end

row_test = 1
for line in io.lines 'Input/testCF.txt' do										--reads each line in 'test.txt'
	avg[row_test], col = 0,0
	for n in line:gmatch'%S+' do
		col = col + 1
		if col < 11 then
			test[col] = (tonumber(n)-min[col])/(max[col]-min[col])		--puts to test[] the value per feature
			avg[row_test] = avg[row_test] + test[col]
		else
			value[row_test] = tonumber(n)
		end
	end
	
	avg[row_test] = avg[row_test]/10									--computes for average of each line/ row
	for i = 1, 10 do
		arr_u[i] = test[i]-avg_user
	end

	wuv[row_test] = {}
	for i = 1, row-1 do
		sum,sum_sqru,sum_sqrv = 0,0,0
		for j = 1, 10 do
			sum = arr_u[j] * arr_v[i][j] + sum							--will be used in computation of similarity
			sum_sqru = math.pow(arr_u[j],2) + sum_sqru
			sum_sqrv = math.pow(arr_v[i][j],2) + sum_sqrv
		end
		wuv[row_test][i] = sum/(math.sqrt(sum_sqru)*math.sqrt(sum_sqrv))	--computes for similarity using Pearson correlation
	end
	row_test = row_test + 1
end

TP,TN,FP,FN = 0,0,0,0
for i = 1, row_test-1 do
	sum_up, sum_weights = 0,0
	for j = 1, row-1 do
		sum_up = (arr_v[j][11] * wuv[i][j]) + sum_up					--will be used in computation of PAI (output)
		sum_weights = math.abs(wuv[i][j]) + sum_weights
	end

	pai[i] = avg[i] + (sum_up/sum_weights)								--computes for output of CF 
	print(pai[i]) 
	file:write(pai[i].."\n")

	if pai[i] < 0.5 and value[i] == 0 then 								--classify output if TN,FN, TP, FP
		TN = TN + 1
	elseif pai[i] < 0.5 and value[i] == 1 then 
		FN = FN + 1
	elseif pai[i] >= 0.5 and value[i] == 1 then 
		TP = TP + 1
	else 
		FP = FP + 1 
	end
end

---------------------ROC measures----------------------------
print("TP = "..TP,"FP = "..FP,"TN = "..TN,"FN = "..FN,"\n")
file:write("TP = ",TP,"\tFP = ",FP,"\tTN = ",TN,"\tFN = ",FN,"\n")
TPR = TP/(TP+FN)
FPR = FP/(FP+TN)
ACC = (TP + TN)/(TP + FN + FP + TN)
SPC = 1 - FPR
print("TPR "..TPR,"FPR "..FPR,"ACC "..ACC,"SPC "..SPC)
file:write("\nTPR = ",TPR," FPR = ",FPR," ACC = ", ACC,"SPC = ",SPC,"\n")