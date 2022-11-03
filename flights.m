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

%% Plots

% figure(2)
% plot(time,dz_est,'Linewidth',line_width);
% hold on
% title('Estimated Velocity');
% xlabel('Time (s)','fontsize',font_size);
% ylabel('Velocity (m/s)','fontsize',font_size);
% legend('dz_{est}','location','best');
% set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
% xlim([0 time(end)]);
% grid on 
% 
% 
% figure(3)
% title('Raw Motor Inputs');
% subplot(2,2,1)
% plot(time,motor1,'Linewidth',line_width); hold on
% xlabel('Time (s)','fontsize',font_size);
% ylabel('Motor Input (RPM)','fontsize',font_size);
% legend('Motor_1','location','best');
% set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
% xlim([0 time(end)]);
% grid on
% 
% subplot(2,2,2)
% plot(time,motor2,'Linewidth',line_width);hold on
% xlabel('Time (s)','fontsize',font_size);
% ylabel('Motor Input (RPM)','fontsize',font_size);
% legend('Motor_2','location','best');
% set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
% xlim([0 time(end)]);
% grid on
% 
% subplot(2,2,3)
% plot(time,motor3,'Linewidth',line_width);hold on
% xlabel('Time (s)','fontsize',font_size);
% ylabel('Motor Input (RPM)','fontsize',font_size);
% legend('Motor_3','location','best');
% set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
% xlim([0 time(end)]);
% grid on
% 
% subplot(2,2,4)
% plot(time,motor4,'Linewidth',line_width);hold on
% xlabel('Time (s)','fontsize',font_size);
% ylabel('Motor Input (RPM)','fontsize',font_size);
% legend('Motor_4','location','best');
% set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
% xlim([0 time(end)]);
% grid on