clc
clear
close all

rng('default') % For reproducibility

% Parameters for data generation
N = 300;  % Size of each cluster
r1 = 0.5; % Radius of first circle
r2 = 5;   % Radius of second circle
theta = linspace(0,2*pi,N)';

X1 = r1*[cos(theta),sin(theta)]+ rand(N,1); 
X2 = 1.5 + r2*[cos(theta),sin(theta)]+ rand(N,1);
X = [X1;X2]; % Noisy 2-D circular data set

x = [10, 10];

X = [x; X];

[idx,corepts] = dbscan(X,1,5); % The default distance metric is Euclidean distance

clear_idx = idx;
clear_idx(corepts==0) = [];

clear_X = X;
clear_X(corepts==0,:) = [];

center1 = mean(clear_X(clear_idx==1,:));
center2 = mean(clear_X(clear_idx==2,:));

figure(1);
hold on;
plot(X(corepts==0, 1),X(corepts==0, 2),'r.','markersize',10);
plot(clear_X(clear_idx==1, 1),clear_X(clear_idx==1, 2),'g.','markersize',10);
plot(clear_X(clear_idx==2, 1),clear_X(clear_idx==2, 2),'c.','markersize',10);
plot(center1(1),center1(2),'kx','markersize',10,'linewidth',2);
plot(center2(1),center2(2),'k+','markersize',10,'linewidth',2);
xlim([-5,15]);
ylim([-5,15]);
axis square;
title('DBSCAN Using Euclidean Distance Metric');
legend('outlier data','cluster #1','cluster #2','cluster center #1','cluster center #2','Location','NorthEastOutside');
