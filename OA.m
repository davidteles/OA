clear;
clc;
close all;

load('p3_group_19_signals.mat');
yt=y';

%For noise removing
P1=10;
P2=2;

tpol_1=[0 75 335 472 585 710 1000];
tpol_2=[0 212 537 595 686 855 1000];

lbda=350;

sinal_1=yt(:,1);
sinal_2=yt(:,2);
sinal_3=yt(:,3);
sinal_4=yt(:,4);
sinal_5=yt(:,5);


for i= 2:2
    sinaldected=[];
    analizing=yt(:,i);
    
    [sinal1,spikes]=l1filterM(analizing,lbda,P1);
    [sinal2,extranoise]=l1filterM(analizing-spikes-sinal1,lbda,P2);
    
    for j= 0:9    
        meanInsideInterval(j+1) = mean(abs(extranoise(100*j+1:100*j+100)));
    end
    for j= 0:9

        if(meanInsideInterval(j+1)>mean(meanInsideInterval) && round(meanInsideInterval(j+1),2)>=0.1)
            sinaldected=cat(1,sinaldected,ones(100));
        else
            sinaldected=cat(1,sinaldected,zeros(100));
        end
        
    end

    if (i==1)
        psinal=polishing(sinal1,tpol_1);
    elseif (i==2)
        psinal=polishing(sinal1,tpol_2);

    else
        psinal=sinal1;
    end

    figure(i)
    plot(analizing,'b');
    hold on;
    plot(sinal1,'m');
    plot(psinal,'r');
    plot(spikes,'y');
    %plot(sinaldected,'k')
    legend('Original Signal','l1 Trend Filtering','Polished Signal','Spikes');
    hold off
    figure(i+5);
    plot(analizing,'b');
    hold on;
    plot(analizing-spikes-sinal1,'y')
    plot(extranoise,'r');
    legend('Original Signal','Gaussian noise','Extranoise');
    hold off
end

periods=randi([25 250],5,1)
index=randi([1 5],1)
periods(index)
    




part3=creat_signal(periods(index),1000);
figure(11)
plot(part3,'y')
hold on
[signal,spykes]=l1filterM(part3',15,P1);
plot(signal,'r')
period=EstimatePeriod(signal,periods)
legend('Original Signal','Filtered SIgnal');
