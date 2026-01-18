function [Signal_ctx, P3R_1R, P3R_1T, E, P_ctx] = ...
    EAM_core(DGvec, J12, J13, J23, g, states, beta, R, T)

% State variables
s1 = states(:,1);
s2 = states(:,2);
s3 = states(:,3);

% Microstate energies
E = s1*DGvec(1) + s2*DGvec(2) + s3*DGvec(3) ...
    - J12 .* (1-s1).*(1-s2) ...
    - J13 .* (1-s1).*(1-s3) ...
    - J23 .* (1-s2).*(1-s3);

% Boltzmann weights
w = exp(-beta .* E);

% Contextual (ligand/DNA) reweighting
Za = exp(-g/(R*T));
w_ctx = w;
w_ctx(s1 == 0) = Za .* w_ctx(s1 == 0);

% Normalized probabilities
P_ctx = w_ctx ./ sum(w_ctx);

% Conditional probabilities
mask_1R    = (s1 == 0);
mask_1R_3R = (s1 == 0 & s3 == 0);
P3R_1R     = sum(P_ctx(mask_1R_3R)) / sum(P_ctx(mask_1R));

mask_1T    = (s1 == 1);
mask_1T_3R = (s1 == 1 & s3 == 0);
P3R_1T     = sum(P_ctx(mask_1T_3R)) / sum(P_ctx(mask_1T));

% Allosteric signal
Signal_ctx = P3R_1R - P3R_1T;

end
