clear all; echo off; close all force; clc; format long; %clear another variables
%% Ex7
%dados
%Forca de frenagem?
%reacoes de apoio
ax=90/1000;
bx=80/1000;
by=30/1000;
b=sqrt(bx^2+by^2);
r=40/1000;
w=30/1000;
% b=90;
% r=100;
% w=30;
theta1=35*2*pi/360;
theta2=155*2*pi/360;
theta_max=90*2*pi/360; %onde ocorre a pressão máxima
mi=0.25;
pmax=1.5e6;

%Torque de atrito

Torque1=mi*w*r^2*pmax/sin(theta_max)*[cos(theta1)-cos(theta2)]

Mn=b*w*r*pmax/sin(theta_max)*[1/2*(theta2-theta1)-1/4*(sin(2*theta2)-sin(2*theta1))]
Mf=mi*w*r*pmax/sin(theta_max)*[-r*(cos(theta2)-cos(theta1))-b/2*((sin(theta2))^2-(sin(theta1))^2)]
M=Mn-Mf %autodesenergizante
Fa=M/ax

% Fa igual nos 2 lados, então isolar os termos para encontrar Pmax no segundo lado
% Fa=(Mn+Mf)/ax
% Fa*ax/w*r=b*A+mi*B

A=[1/2*(theta2-theta1)-1/4*(sin(2*theta2)-sin(2*theta1))]
B=[-r*(cos(theta2)-cos(theta1))-b/2*((sin(theta2))^2-(sin(theta1))^2)]

pmax2=Fa*ax*sin(theta_max)/(w*r*(b*A+mi*B))

Torque2=mi*w*r^2*pmax2/sin(theta_max)*[cos(theta1)-cos(theta2)]
Torque=Torque1+Torque2
