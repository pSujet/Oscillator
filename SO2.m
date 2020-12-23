%% Neural Control Oscillator
% SO2

%% Clear
clc;
clear all;
close all;

%% Define value
% CPG
t = 2000;
time = 1:t;
count = 0;
for i=1:length(time)-1
alpha = 1.011;
phi = pi/3;%pi/12; %f = phi/(2*pi)
w11 = alpha*cos(phi);
w12 = alpha*sin(phi);
w21 = -alpha*sin(phi);
w22 = alpha*cos(phi);
a1(i+1) = w11*H1(i)+w12*H2(i)+B1;
a2(i+1) = w22*H2(i)+w21*H1(i)+B2;
H1(i+1) = tanh(a1(i+1));
H2(i+1) = tanh(a2(i+1));
end

%CPG Plot
figure
plot(time,H1,'-o');
hold on
plot(time,H2);
xlim([0 500]);
grid on;
xlabel("Time[steps]")
ylabel("CPG")
title("MI = 0.04")
disp(max(H1)) 
figure,plot(H1,H2)

