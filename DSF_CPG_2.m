%% Neural Control Oscillator
% DSF-CPG

%% Clear
clc;
clear all;
close all;

%% Define value
% CPG weight
alpha = 1;%1.011;
phi = 0.45;
w11 = alpha*cos(phi);
w12 = alpha*sin(phi);
w21 = -alpha*sin(phi);
w22 = alpha*cos(phi);
gamma = 0.3;
beta = 0.2;
factor1 = 2;
factor2 = 0;
factor3 = 5;
% initial setup
t = 2000;
time = 1:t;
count = 0;
a1 = 0.01;
a2 = 0.01;
position = 0;
target = 0;

for i=1:length(time)-1
    position(i+1) = target(i);
    if i >= 300 && i<=500
        position(i+1) = 0.4;
    else
        position(i+1) = target(i);
    end
a1_p(i+1) = atanh(invF(position(i),factor1,factor2));
% === Dynamical System ===
a1(i+1) = w11.*tanh((1-gamma).*a1(i)+gamma.*a1_p(i))+w12.*tanh(a2(i)) ...
          + gamma*a1_p(i) + beta.*a1(i);
a2(i+1) = w22*tanh(a2(i))+w21*tanh(a1(i));
a1(i) = a1(i+1);
a2(i) = a2(i+1);
% ========== End ==========
out1(i) = tanh(a1(i));
out2(i) = tanh(a2(i));

target(i+1) = F(out1(i),factor1,factor2);

end

%CPG Plot
figure
plot(time,target,'-');
hold on
plot(time,position);
xlim([0 1000]);
grid on;
xlabel("Time[steps]")
ylabel("CPG")
title("DSF-CPG v2")
figure,plot(out1,out2,'-o')

%% Define Function
function position = F(activation,factor1,factor2)
    position = (activation * factor1) + factor2;
end

function activation = invF(position,factor1,factor2)
    activation = (position - factor2)/factor1;
end

