% Validate the centroid and Hu-invariants with the 2D Hypnogram
close all; clear; clc;

X = gen2DHypnogram('plot flag', 1);
c_moments = Cal_Central_Moments_Of_Images(X, 'plot flag', 1);

c_moments1 = c_moments(:,1);
[sorted_idx, previous_idx] = getEnumeratedIdx(c_moments1);
figure;
subplot(1,2,1); plot(c_moments1);
subplot(1,2,2); plot(c_moments1(sorted_idx));

figure;
N = length(X);
for n = 1 : N
    subplot(2,ceil(N/2), n);
    imshow(X{sorted_idx(n)}, 'InitialMagnification', 10000);
end

c_moments4 = c_moments(:,4);
[sorted_idx, previous_idx] = getEnumeratedIdx(c_moments4);
figure;
subplot(1,2,1); plot(c_moments4);
subplot(1,2,2); plot(c_moments4(sorted_idx));

figure;
N = length(X);
for n = 1 : N
    subplot(2,ceil(N/2), n);
    imshow(X{sorted_idx(n)}, 'InitialMagnification', 10000);
end