%% Neural Control Oscillator
% SO2

%% Clear
clc;
clear all;
close all;

%% Define value
% CPG weight
alpha = 1;%1.011;
phi = 0.45;%pi/12;%pi/12; %f = phi/(2*pi)
w11 = alpha*cos(phi);
w12 = alpha*sin(phi);
w21 = -alpha*sin(phi);
w22 = alpha*cos(phi);
% initial setup
t = 2000;
time = 1:t;
count = 0;
H = [0.01;0];
for i=1:length(time)-1

% % === Dynamical System ===
% a1 = w11*o1+w12*o2;
% a2 = w22*o2+w21*o1;
% o1 = tanh(a1);
% o2 = tanh(a2);
% % ========== End ==========

% === Dynamical System ===
H = [H [tanh(w11*H(1,i)+w12*H(2,i));...
        tanh(w22*H(2,i)+w21*H(1,i))]];                   
% ========== End ==========

end

%CPG Plot
figure
plot(time,H(1,:),'-');
hold on
plot(time,H(2,:));
xlim([300 500]);
grid on;
xlabel("Time[steps]")
ylabel("CPG")
title("SO2")
figure,plot(H(1,:),H(2,:),'-o')

