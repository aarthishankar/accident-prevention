num1 = xlsread('E:\MATLAB\R2014a\bin\hogsvm\hogg.xlsx');
save aarthi1.mat num1
load aarthi1.mat
num2=xlsread('E:\MATLAB\R2014a\bin\hogsvm\tttttt.xlsx');
save aarthi2.mat num2
load aarthi2.mat
c=[];
Sample=[];
for i=1:9
c(:,i)=num1(:,i);
Sample(:,i)=num2(:,i);
end
y=num1(:,10);

[cc]=multisvm(c,y,Sample);

