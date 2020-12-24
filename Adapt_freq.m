%% Neural Control Oscillator
% Adaptive Frequency 

%% Clear
clc;
clear all;
close all;

%% Define Parameters
out1 = [];
ext = [];
err = [];
%AFC parameters
x_dot = 0.0; 
y_dot = 0.0; 
w_dot = 0.0; 
y = 0.0;
E = 10;
w = 35; %random initial freq
x = 1.0;
wd = 10; %entrained freq
mu = 1.0;
%initial setup
t = 50;
tstep = 0.01;
time = 0:tstep:t;

for i = 1:length(time)
F = 2*sin(wd*time(i)); 
% === Dynamical System ===
x_dot = (mu-(x^2+y^2))*x-w*y+E*F;
y_dot = (mu-(x^2+y^2))*y+w*x;
w_dot = -1*E*F*(y./(sqrt(x^2+y^2)));
%disp(w_dot)
% ========== End ==========
x = x + tstep*x_dot;
y = y + tstep*y_dot;
w = w + tstep*w_dot;
disp(w)
out1(i) = x;
ext(i) = F;
error = w-wd;
err(i) = error;
end

%% Plot
figure,plot(time,out1)
hold on 
plot(time,ext)
%xlim([10,15])
figure,plot(time,err)
