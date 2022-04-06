%This script does the combinatorial analysis
clear 
load X %CpG
load Y %0 or 1 indetifirer (vontrol vs. patient)

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

for i=1:100
net = patternnet([100]);
net = train(net,XTrain,YTrain);

YPre = round(net(XTest));
Check= YTest==YPre;
Accu(i)=sum(Check)/length(Check);
Media=mean(Accu);
%Desviacion=std(Accu);
end
M(1)=Media;
clear Media
clear Desviacion

for j=2:10000
%Reduce by one
XXTemp=X;
del=randi ([1,length(X)])
XXTemp(del,:) = []

XTrain=XXTemp(:,1:l);
XTest=XXTemp(:,l+1:end);

for i=1:100
net = patternnet([100]);
net = train(net,XTrain,YTrain);

YPre = round(net(XTest));
Check= YTest==YPre;
Accu(i)=sum(Check)/length(Check);
Media=mean(Accu);
%Desviacion=std(Accu);
end

M(j)=Media

if M(j)>M(j-1)
    X=XXTemp;
else
    M(j)=M(j-1)
end

clear Media
clear Desviacion
end

%plot(M)