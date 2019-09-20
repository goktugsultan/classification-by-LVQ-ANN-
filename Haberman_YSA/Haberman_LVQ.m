clear all;  clc;

% initial weight values
w1=[33.7 62 3.4]; 
w2=[39 61.5 6.5];

LR=0.5;

name = 'HabermanData.txt'; % import data
M = dlmread(name, ','); % split data
M=M(1:140,:);
y1=1;
y2=2;
x1=M(:,1);x2=M(:,2);x3=M(:,3); % x1:age attribute, x2:year attribute, x3=nodule 
target=M(:,4);                 % target:survival status

iterasyon=0;

while iterasyon<70000           % optimal iteration count
    for i=1:140                 % data lenght
        d1=sqrt(((x1(i)-w1(1))^2+(x2(i)-w1(2))^2+(x3(i)-w1(3))^2));   % calculation of reference vectors (d1, d2) using euclidean distance
        d2=sqrt(((x1(i)-w2(1))^2+(x2(i)-w2(2))^2+(x3(i)-w2(3))^2));
        
        if d1<d2                % comparison of reference vectors
            if y1==target(i)    % accuracy class check 
                X=[x1(i),x2(i),x3(i)];    
                DW=LR*(X-w1);
                w1=w1+DW;       % reference vector for d1 
                X=[x1(i),x2(i),x3(i)];
                DW=LR*(X-w2);
                w2=w2-DW;        % reference vector for d2
            else             
                X=[x1(i),x2(i),x3(i)];  
                DW=LR*(X-w1);
                w1=w1-DW;        % reference vector for d1 
                X=[x1(i),x2(i),x3(i)];  
                DW=LR*(X-w2);
                w2=w2+DW;        % reference vector for d2
            end        
            
        elseif d2<d1            % comparison of reference vectors
            if y2==target(i)
                X=[x1(i),x2(i),x3(i)];
                DW=LR*(X-w2);
                w2=w2+DW;
                X=[x1(i),x2(i),x3(i)];
                DW=LR*(X-w1);
                w1=w1-DW;
            else
                X=[x1(i),x2(i),x3(i)];
                DW=LR*(X-w2);
                w2=w2-DW;
                X=[x1(i),x2(i),x3(i)];
                DW=LR*(X-w1);
                w1=w1+DW;
            end
        end
    end  
  
    if iterasyon==50000 % if iteration count == 50000 Learning rate decrease
        LR=LR-0.2;
    end   
    
    if LR<=0
        display('LR-----');
        break;
    end
   
   
iterasyon=iterasyon+1;  
disp(iterasyon);  % display of the number of iterations
end
