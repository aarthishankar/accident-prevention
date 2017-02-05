clear; close all; clc;
training_car = 'E:\MATLAB\R2014a\bin\hogsvm\car';
training_human = 'E:\MATLAB\R2014a\bin\hogsvm\human';
test_set = 'E:\MATLAB\R2014a\bin\hogsvm\test';

filenames_1 = dir(fullfile(training_car, '*.jpg'));
filenames_2 = dir(fullfile(training_human, '*.jpg'));
filenames_3 = dir(fullfile(test_set, '*.jpg'));


total_images_1 = numel(filenames_1);
total_images_2 = numel(filenames_2);
total_images_3 = numel(filenames_3);


featureMatrix_1 = [];
featureMatrix_2 = [];
featureMatrix_3 = [];


for n = 1:total_images_1    
full_name= fullfile(training_car, filenames_1(n).name);
training_images_1 = imread(full_name);
[featureVector_1, hogVisualization_1] = extractHOGFeatures(training_images_1);

featureMatrix_1{n} = featureVector_1;
figure (n)
    imshow(training_images_1);                   
    plot(hogVisualization_1);
    save('a.mat','featureMatrix_1');  
end

maxSize= max(cellfun(@numel,featureMatrix_1));
    fon=@(x) [x zeros(1,maxSize-numel(x))];
    rmatc=cellfun(fon,featureMatrix_1,'UniformOutput',false);
    rmatc=vertcat(rmatc{:});
%    rmat(:,:)=rmat(all(rmat==0,2),:);
    rmatc2=mean(rmatc.')';
    rmatc3=var(rmatc.')';
    rmatc4=moment(rmatc.',3)';  
 %   rmat4=median(rmat,2);
    rmatc5=max(rmatc,[],2);
    rmatc6=std(rmatc.')';
  %  rmat5=min(rmat,[],2);
    concatc=cat(2,rmatc2,rmatc3,rmatc4,rmatc5,rmatc6);
% %         
% %         for m=1:10
% % 
% %              b(m,1)=mean(cell2mat(featureMatrix_1(1,m)));
% %              b(m,2)=var(cell2mat(featureMatrix_1(1,m)));
% %              %b(m,3)=entropy(cell2mat(featureMatrix_1(1,m)));
% %              hold on;
% %         end
for i = 1:total_images_2    
full_name_2= fullfile(training_human, filenames_2(i).name);
training_images_2 = imread(full_name_2);

[featureVector_2, hogVisualization_2] = extractHOGFeatures(training_images_2);
featureMatrix_2{i} = featureVector_2;

figure (i)
    imshow(training_images_2);                 
    plot(hogVisualization_2);
    
   save('a1.mat','featureMatrix_2');  

end
    

maxSize= max(cellfun(@numel,featureMatrix_2));
    fon=@(x) [x zeros(1,maxSize-numel(x))];
    rmath=cellfun(fon,featureMatrix_2,'UniformOutput',false);
    rmath=vertcat(rmath{:});
    %rmat(:,:)=rmat(all(rmat==0,2),:);
    rmath2=mean(rmath.')';
    rmath3=var(rmath.')';
    rmath4=moment(rmath.',3)';
    %rmat4=median(rmat,2);
    rmath5=max(rmath,[],2);
    %rmat5=min(rmat,[],2);
    rmath6=std(rmath.')';
    concath=cat(2,rmath2,rmath3,rmath4,rmath5,rmath6);
%     
% %     for l= 1:10
% %          for m= 1:10
% %             x1(l,m)=cos(2*pi*100*rmat(l,m))+cos(2*pi*200*rmat(l,m))+sin(2*pi*300*rmat(l,m));
% %             power(l,1) = (norm(x1(l,1))^2)/length(x1(l,1));
% %          end
% %     end
%             
%             %  for p=1:10
% %     
% %              r(p,1)=mean(cell2mat(featureMatrix_2(1,p)));
% %              r(p,2)=var(cell2mat(featureMatrix_2(1,p)));
% %             % r(p,2)=entropy(single(cell2mat(featureMatrix_2(1,p))));
% %              hold on;
% %  end
%         
for j = 1:total_images_3
full_name_3= fullfile(test_set, filenames_3(j).name);

training_images_3 = imread(full_name_3);

[featureVector_3, hogVisualization_3] = extractHOGFeatures(training_images_3);
featureMatrix_3{j} = featureVector_3;

figure (j)
    imshow(training_images_3);                  
    plot(hogVisualization_3);
save('a2.mat','featureMatrix_3');
end
% for p=1:1
%             s(p,1)=mean(cell2mat(featureMatrix_3(1,p)));
%             s(p,2)=var(cell2mat(featureMatrix_3(1,p)));
%             hold on;
% end
maxSize= max(cellfun(@numel,featureMatrix_3));
    fon=@(x) [x zeros(1,maxSize-numel(x))];
    rmatt=cellfun(fon,featureMatrix_3,'UniformOutput',false);
    rmatt=vertcat(rmatt{:});
   % rmat(:,:)=rmat(all(rmat==0,2),:);
    rmatt2=mean(rmatt.')';
    rmatt3=var(rmatt.')';
    rmatt4=moment(rmatt.',3)';
    %rmat4=median(rmat,2);
    rmatt5=max(rmatt,[],2);
    %rmat5=min(rmat,[],2);
    rmatt6=std(rmatt.')';
    concatt=cat(2,rmatt2,rmatt3,rmatt4,rmatt5,rmatt6);
