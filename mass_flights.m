%% Added Mass Experiments
% Trevor Burgoyne 13 Nov 2022

% Paths for data loading
ROOT_DIR = "C:/Users/Trevor/Desktop/AEM 4602W/Controls-Lab/Data/Part 3/";
PREFIX = "pjsdata_P3T";
DISP_NAME = "Added Mass";
LABEL_NAME = "Run";
N_TESTS = 2;
N_RUNS = 2;
masses = [79.3, 80.6] / 1000; % kg
[avg_hss, var_hss, avg_kt, var_kt, kphat, kdhat, kp, kd] = make_graphs(ROOT_DIR, PREFIX, DISP_NAME, LABEL_NAME, N_TESTS, N_RUNS, masses)

for test_n=1:N_TESTS
    [wn, zeta] = Low_Fidelity_Model(DISP_NAME, masses(test_n), avg_kt(test_n), kp(test_n), kd(test_n));
end