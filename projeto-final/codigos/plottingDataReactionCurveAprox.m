clear all;
close all;
clc;

sim('Smith')

dataReactionCurveCoolingdown = ans.dataReactionCurveCoolingdownAprox.signals.values;
dataReactionCurveHeating = ans.dataReactionCurveHeatingAprox.signals.values;
time = ans.dataReactionCurveHeatingAprox.time;



% dataReactionCurveCoolingdown
% dataReactionCurveHeating