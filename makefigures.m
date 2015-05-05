rcmstr = '';
if reducebandwidth
    rcmstr = '; Using RCM algorithm';
end

lapfig=figure(101);
set(lapfig,'Position',[50 100 400 600])
subplot(3,1,1);
ttl1 = sprintf('Graph Lap: Number of 0 eigvals vs size\n Conn. Comp. = %i%s',num_conncomp,rcmstr);
title(ttl1);
xlabel('Matrix Size');
ylabel('Number of zero eig values');
xlim([0 max_size]);
hold on;
plot([0 max_size],[num_conncomp,num_conncomp],'k')

% figure(102);
subplot(3,1,2);
ttl2=sprintf('Graph Lap: Number of positive eigvals vs size\n Conn. Comp. = %i%s',num_conncomp,rcmstr);
title(ttl2);
xlabel('Matrix Size');
ylabel('Number of pos eig values');
xlim([0 max_size]);
hold on;
plot([0 max_size],[num_conncomp,max_size-num_conncomp],'k')

% figure(103);
subplot(3,1,3);
ttl3=sprintf('Graph Lap: Number of neg eigvals vs size\n Conn. Comp. = %i%s',num_conncomp,rcmstr);
title(ttl3);
xlabel('Matrix Size');
ylabel('Number of neg eig values');
xlim([0 max_size]);
hold on;
plot([0 max_size],[0,0],'k')

timelapfig=figure(102);
set(timelapfig,'Position',[500 500 500 300])
ttl4=sprintf('Graph Lap: time LDL computed vs size\n Conn. Comp. = %i%s',num_conncomp,rcmstr);
title(ttl4);
xlabel('Matrix size')
ylabel('Time to compute LDL');
xlim([0 max_size]);
hold on;

% ---

tollap=figure(201);
set(tollap,'Position',[1100 100 400 600])
subplot(3,1,1);
ttl1=sprintf('TOL Graph Lap: Number of eigvals equal to tol vs size\n Conn. Comp. = %i%s',num_conncomp,rcmstr);
title(ttl1);
xlabel('Matrix Size');
ylabel('Number of eig values within tol');
xlim([0 max_size]);
hold on;
plot([0 max_size],[num_conncomp,num_conncomp],'k')

% figure(202);
subplot(3,1,2);
ttl2=sprintf('TOL Graph Lap: Number of eigvals above tol vs size\n Conn. Comp. = %i%s',num_conncomp,rcmstr);
title(ttl2);
xlabel('Matrix Size');
ylabel('Number of eig values above tol');
xlim([0 max_size]);
hold on;
plot([0 max_size],[num_conncomp,max_size-num_conncomp],'k')

% figure(203);
subplot(3,1,3);
ttl3=sprintf('TOL Graph Lap: Number of eigvals below tol vs size\n Conn. Comp. = %i%s',num_conncomp,rcmstr);
title(ttl3);
xlabel('Matrix Size');
ylabel('Number of neg eig values');
xlim([0 max_size]);
hold on;
plot([0 max_size],[0,0],'k')

toltime=figure(202);
set(toltime,'Position',[500 100 500 300])
ttl4=sprintf('TOL Graph Lap: time LDL computed vs size\n Conn. Comp. = %i%s',num_conncomp,rcmstr);
title(ttl4);
xlabel('Matrix size')
ylabel('Time to compute LDL');
xlim([0 max_size]);
hold on;

