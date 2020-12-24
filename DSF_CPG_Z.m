%% Neural Control Oscillator
% Test CPG

%% Clear
clc;
clear all;
close all;

%% Define value
tgt = [];
pos = [];
act1 = [];
act2 = [];
% CPG weight
alpha = 1.4;%1;
phi = pi/20;%0.45
w11 = alpha*cos(phi);
w12 = alpha*sin(phi);
w21 = -alpha*sin(phi);
w22 = alpha*cos(phi);

% w11 = 1.4;
% w12 = 0.23;
% w21 = -0.23;
% w22 = 1.4;

gamma = 0.67;
gamma = 1.4;% P'Zumo
%gamma = 1.01;% Zeta
factor1 = 2;
factor2 = 0;
% initial setup
t = 50;
tstep = 0.01;
time = 0:tstep:t;
o1 = 0.01;
o2 = 0;
position = 0;
target = 0;

for i=1:length(time)
position = target;
    if i >= 350 && i<=750
        position = 0.5;
    else
        position = target;
    end

o1_p = invF(position,factor1,factor2);

% % % === Dynamical System ===
% a1 = w11 * (o1 - gamma * (o1 - o1_p)) + w12 * o2; 
% a2 = w22 * o2 + w21 * o1;
% o1 = tanh(a1);
% o2 = tanh(a2);
% % % ========== End ==========

%P'Zumo form
%=== Dynamical System ===
a1 = w11 * o1 + w12 * o2 - gamma * (o1 - o1_p); 
a2 = w22 * o2 + w21 * o1;
o1 = tanh(a1);
o2 = tanh(a2);
%========== End ==========

act1(i) = o1;
act2(i) = o2;
pos(i) = position;
tgt(i) = target;
target = F(o1,factor1,factor2);

end

%% Plot
%CPG Plot
figure
plot(time,tgt,'-');
hold on
plot(time,pos);
xlim([0 10]);
grid on;
xlabel("Time[steps]")
ylabel("CPG")
title("DSF-CPG")
figure,plot(act1,act2,'-o')

%% Define Function
function position = F(activation,factor1,factor2)
    position = (activation * factor1) + factor2;
end

function activation = invF(position,factor1,factor2)
    activation = (position - factor2)/factor1;
end

