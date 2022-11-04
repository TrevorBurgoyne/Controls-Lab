%% High-Fidelity, Added Mass Sims
% Trevor Burgoyne 13 Nov 2022

% Paths for data loading
ROOT_DIR = "C:/Users/Trevor/Desktop/AEM 4602W/Controls-Lab/Data/Part 3/";
PREFIX = "part3_t";
DISP_NAME = "Added Mass";
LABEL_NAME = "High Sim";
N_TESTS = 2;
N_RUNS = 1;
masses = [79.3, 80.6] / 1000; % kg
[avg_hss, var_hss, avg_kt, var_kt, kphat, kdhat, kp, kd] = make_graphs(ROOT_DIR, PREFIX, DISP_NAME, LABEL_NAME, N_TESTS, N_RUNS, masses)