%This script calculates an indicative accuracy prediction for each CpG
clear 
load X %CpGs matrix contaning only the methylation levels for each patient 
%one column=one patient, one row=one CpG. Data downloaded from GEO database are
%in this basic arrangement .
load Y %0 or 1 identifier (control vs. patient)

s=length(Y);
%define the lenght of the trining datatset
l=46;

%intial iteration
%Training dataset 
YTrain=Y(1:l);
XTrain=X(:,1:l);

%Testing dataset
YTest=Y(l+1:end);
XTest=X(:,l+1:end);


%tic

for j=1:length(X)
net = patternnet([100]);
XX=XTrain(j,:);
XXX=XTest(j,:);

for i=1:100
net = train(net,XX,YTrain);
YPre = round(net(XXX));

Check= YTest==YPre;
Accu(i)=sum(Check)/length(Check);
Media=mean(Accu);
Desviacion=std(Accu);
end

Precision(j)=Media;
Des(j)=Desviacion;
clear Media
clear Desviacion

end
%toc
%csvwrite('Media.csv',Precision')
%csvwrite('DesviacionStandard.csv',Des')
