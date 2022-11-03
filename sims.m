%% High-Fidelity, No Mass Sims
% Trevor Burgoyne 13 Nov 2022

% Paths for data loading
ROOT_DIR = "C:/Users/Trevor/Desktop/AEM 4602W/Controls-Lab/Data/Part 2/";
PREFIX = "sim_t";
DISP_NAME = "No Added Mass";
LABEL_NAME = "Sim";
N_TESTS = 2;
N_RUNS = 1;
[avg_hss, var_hss] = make_graphs(ROOT_DIR, PREFIX, DISP_NAME, LABEL_NAME, N_TESTS, N_RUNS)