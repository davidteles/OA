function period=EstimatePeriod(signal,periods)

    n=size(signal,1);

    period=0;
    minimum=9999;
    %plot(signal);

    
    for i = 1:size(periods,1)
        meanInsideInterval=0;
        j=0;
        if periods(i)~=0 && periods(i)<n/2
            while (j+1)*periods(i)<n
                
                meanInsideInterval(j+1) = mean(signal(periods(i)*j+1:periods(i)*(j+1)));
                j = j+1;
            end

            
            f=0;
            size(meanInsideInterval,2);
            for j = 1:2:(size(meanInsideInterval,2)-1)
                
                f=abs(meanInsideInterval(j)-meanInsideInterval(j+1))+f;
            end
            
            if(period==0 | minimum>f)

                period=periods(i);
                minimum=f;

            end
        end
        
    end
    
    
    

