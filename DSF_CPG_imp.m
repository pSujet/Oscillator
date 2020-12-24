%% Neural Control Oscillator
% DSF-CPG

%% Clear
clc;
clear all;
%close all;

%% Define value
tgt = [];
pos = [];
act1 = [];
act2 = [];
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
% initial setup
t = 50;
tstep = 0.01;
time = 0:tstep:t;
a1 = 0.01;
a2 = 0.01;
position = 0;
target = 0;

for i=1:length(time)
position = target;
    if i >= 350 && i<=750
        position = 1.1;
    else
        position = target;
    end
a1_p = atanh(invF(position,factor1,factor2));

% === Dynamical System ===
a1_1 = w11.*tanh((1-gamma).*a1+gamma.*a1_p)+w12.*tanh(a2) ...
          + gamma*a1_p + beta.*a1;
a2_1 = w22*tanh(a2)+w21*tanh(a1);
a1 = a1_1;
a2 = a2_1;
% ========== End ==========

out1 = tanh(a1);
out2 = tanh(a2);
act1(i) = a1;
act2(i) = a2;
pos(i) = position;
tgt(i) = target;
target = F(out1,factor1,factor2);

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

