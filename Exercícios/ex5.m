clear all; echo off; close all force; clc; format long; %clear another variables
%% Ex5
%dados
%Torque?
%Forca de frenagem?
a=180/1000;
b=90/1000;
r=100/1000;
w=30/1000;
% b=90;
% r=100;
% w=30;
theta1=30*2*pi/360;
theta2=120*2*pi/360;
theta_max=90*2*pi/360;
mi=0.35;
pmax=1.5e6;

%Torque devido a força normal

Mn=b*w*r*pmax/sin(theta_max)*[1/2*(theta2-theta1)-1/4*(sin(2*theta2)-sin(2*theta1))]
Mf=mi*w*r*pmax/sin(theta_max)*[-r*(cos(theta2)-cos(theta1))-b/2*((sin(theta2))^2-(sin(theta1))^2)]

M=Mn-Mf

Fa=M/a

Torque=mi*w*r^2*pmax/sin(theta_max)*[cos(theta1)-cos(theta2)]
