%% EAM_parameters.m
% Centralized parameter definition for PARP1 EAM

% Physical constants
R    = 1.987e-3;   % kcal/mol/K
T    = 298;        % K
beta = 1/(R*T);

% Intrinsic domain penalties (kcal/mol)
DG1 = 1.0;   % ZnF1
DG2 = 1.0;   % ZnF3
DG3 = 1.0;   % WGR
DGvec = [DG1 DG2 DG3];

% Wild-type coupling energies (kcal/mol)
J12_WT = 3.08;   % ZnF1–ZnF3
J13_WT = 1.20;   % ZnF1–WGR
J23_WT = 0.80;   % ZnF3–WGR

% Ligand / DNA context bias (kcal/mol)
g_ctx = 0.5;

% Mutation scan ranges (kcal/mol)
x_range = linspace(-3, 3, 61);   % ΔJ12
y_range = linspace(-3, 3, 61);   % ΔJ13

% Reference mutation point (for energy plots)
x_mut_bar = 0.05;
y_mut_bar = 0.10;

% Numerical stability
eps_fd = 1e-9;

% Microstate definitions (s1 s2 s3)
states = [ ...
    0 0 0;  % RRR
    1 0 0;  % TRR
    0 1 0;  % RTR
    0 0 1;  % RRT
    1 1 0;  % TTR
    1 0 1;  % TRT
    0 1 1;  % RTT
    1 1 1]; % TTT

state_labels = {'RRR','TRR','RTR','RRT','TTR','TRT','RTT','TTT'};
