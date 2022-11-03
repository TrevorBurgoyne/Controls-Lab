%% Flight Experiments
% Trevor Burgoyne 13 Nov 2022

% Paths for data loading
ROOT_DIR = "C:/Users/Trevor/Desktop/AEM 4602W/Controls-Lab/Data/Part 1/";
PREFIX = "pjsdata_T";
DISP_NAME = "No Added Mass";
LABEL_NAME = "Run";
N_TESTS = 3;
N_RUNS = 2;
masses = [68.1, 68, 69.5] / 1000; % kg
[avg_hss, var_hss, avg_kt, kphat, kdhat, kp, kd] = make_graphs(ROOT_DIR, PREFIX, DISP_NAME, LABEL_NAME, N_TESTS, N_RUNS, masses)

% Generate Low Fidelity Model Plots
for test_n=1:N_TESTS
    [wn, zeta] = Low_Fidelity_Model(DISP_NAME, masses(test_n), avg_kt(test_n), kp(test_n), kd(test_n))
end