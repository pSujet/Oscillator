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
H1 = 0.01;
H2 = 0;
for i=1:length(time)-1

% % === Dynamical System ===
% a1(i+1) = w11*H1(i)+w12*H2(i);
% a2(i+1) = w22*H2(i)+w21*H1(i);
% H1(i+1) = tanh(a1(i+1));
% H2(i+1) = tanh(a2(i+1));
% % ========== End ==========
% === Dynamical System ===
H1(i+1) = tanh(w11*H1(i)+w12*H2(i));
H2(i+1) = tanh(w22*H2(i)+w21*H1(i));
% ========== End ==========

end

%CPG Plot
figure
plot(time,H1,'-');
hold on
plot(time,H2);
xlim([300 500]);
grid on;
xlabel("Time[steps]")
ylabel("CPG")
title("SO2")
disp(max(H1)) 
figure,plot(H1,H2,'-o')

