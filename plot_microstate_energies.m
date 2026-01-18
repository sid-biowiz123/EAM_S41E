%% plot_delta_log_probability.m
clear; clc;
run('EAM_parameters.m');

% WT
[~,~,~,~,P_WT] = EAM_core( ...
    DGvec, J12_WT, J13_WT, J23_WT, g_ctx, states, beta, R, T);

% Mutant
J12_mut = J12_WT + x_mut_bar;
J13_mut = J13_WT + y_mut_bar;
[~,~,~,~,P_mut] = EAM_core( ...
    DGvec, J12_mut, J13_mut, J23_WT, g_ctx, states, beta, R, T);

delta_logP = log(P_mut) - log(P_WT);

figure;
bar(delta_logP);
set(gca,'XTick',1:8,'XTickLabel',state_labels);
ylabel('\Delta log P_i');
title('State-wise population reweighting by mutation');
grid on;
