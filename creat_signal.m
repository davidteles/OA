function [y,T]=creat_signal(T,Duration)

    NumChannel = 1;
    %T=T/10;
    %Duration=1000;
    u = (idinput([Duration+1,NumChannel],'rgs'))';
    t = 0:1:Duration;
    x = sawtooth(2*pi*(1/T)*t);
    signal = awgn(x,30);
    y = signal + u*0.5;
