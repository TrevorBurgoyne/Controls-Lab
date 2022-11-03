%% Flight Experiments
% Trevor Burgoyne 16 Oct 2022

% Paths for data loading
ROOT_DIR = "C:/Users/Trevor/Desktop/AEM 4602W/Controls-Lab/Data/";
COLORS = ["red", "blue", "green", "black"];
N_TESTS = 3;
N_RUNS = 2;
T_START = 20; % s
T_END = T_START+25; % s
HREF = -1.25; % m

% Plotting options
font_size = 15;
line_size = 15;
line_width = 2;

for test_n=1:N_TESTS
    ts = zeros(1,N_RUNS);
    kt = zeros(1,N_RUNS);
    figure(test_n)
    hold on
    for run_n=1:N_RUNS
        path = ROOT_DIR + "Part 1/pjsdata_T" + test_n + "R" + run_n + ".mat";
        load(path);
        if run_n == 1 % Only plot reference once
            plot(time,-z_ref,'Linewidth',line_width,'Color',COLORS(4));
        end
        plot(time,-z_est,'Linewidth',line_width,'Color',COLORS(run_n));
        
        
    end
    title("Test " + test_n + " Estimated vs. Reference Position");
    xlabel('Time (s)','fontsize',font_size);
    ylabel('Altitude (m)','fontsize',font_size);
    legend('z_{ref}','Run 1','Run 2','location','best');
    set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
    xlim([0 time(end)]);
    grid on
end

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