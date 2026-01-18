%% plot_fold_drop_landscape.m

clear; clc;
run('EAM_parameters.m');

% WT signal
[Signal_WT, ~, ~, ~, ~] = EAM_core( ...
    DGvec, J12_WT, J13_WT, J23_WT, g_ctx, states, beta, R, T);

nx = numel(x_range);
ny = numel(y_range);
fold_drop = zeros(ny, nx);

for iy = 1:ny
    for ix = 1:nx
        J12_mut = J12_WT + x_range(ix);
        J13_mut = J13_WT + y_range(iy);

        Signal_mut = EAM_core( ...
            DGvec, J12_mut, J13_mut, J23_WT, g_ctx, states, beta, R, T);

        fold_drop(iy, ix) = abs(Signal_WT) / ...
            (abs(Signal_mut) + eps_fd);
    end
end

[X, Y] = meshgrid(x_range, y_range);

figure;
surf(X, Y, fold_drop, 'EdgeColor','none');
xlabel('\Delta J_{12} (ZnF1–ZnF3)');
ylabel('\Delta J_{13} (ZnF1–WGR)');
zlabel('Fold drop');
title('Mutation-induced fold-drop landscape');
colorbar;
view(135,30);
grid on;
