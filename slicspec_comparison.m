%{
    MA30128: Spring 2015
    Created: March 2, 2015

    This script will compare two methods of slicing the spectrum for finding
    the number of connected components in a graph. The first method looks for
    exactly zero eigenvalues in the laplacian matrix, and the second method
    counts eigenvalues above, below, and equal to a fixed tolerance (10^-8). 
%}

close all
clc

%  consts
num_conncomp = 10;
tol = 10^-8;
max_size = 3000;
step = 50;
num_per = 10;
useposedges = 1;
reducebandwidth = 0;

% set up figures
makefigures;

% set up tables to record stuff for exact zero
exactZero_times = zeros(max_size/step,num_per);
% set up tables to record stuff for tolerance
tolZero_times = zeros(max_size/step,num_per);

% for each size
for ss = step:step:max_size
%     for each trial
    for tt = 1:num_per
%         create the connected components
        components = cell(1,num_conncomp);
        comp_size = ss/num_conncomp;
        check_totalVert = 0;
        for cc = 1:num_conncomp
            components{cc}=makeGLap(comp_size,useposedges);
            check_totalVert = check_totalVert + comp_size;
        end
%         construct the block diagonal
        LL = blkdiag(components{:});
        if check_totalVert ~= ss
            error('Size is not as expected!!')
        end
%         for the laplacian:
%         start timer
%         laplTime = tic;
%         perform ldl
        if reducebandwidth
            rcm_LL = symrcm(LL);
            laplTime = tic;
            [l d p] = ldl(LL(rcm_LL,rcm_LL));
        else
            laplTime = tic;
            [l d p] = ldl(LL);
        end
%         end timer
        exactZero_times(ss,tt)=toc(laplTime);
%         count: zero, pos, neg
        eigvals = diag(d);
        num_zeros = sum(eigvals == 0);
        num_pos = sum(eigvals > 0);
        num_neg = sum(eigvals < 0);
%         plot on 101; 102: the counts, expected counts; and times
        figure(101);
        subplot(3,1,1);
        plot(ss,num_zeros,'bo');
        subplot(3,1,2);
        plot(ss,num_pos,'ro');
        subplot(3,1,3);
        plot(ss,num_neg,'go');
        
        figure(102);
        plot(ss,exactZero_times(ss,tt),'mo');

%         for the tolerance laplacian
%         construct tol_lap
        tol_LL = LL-tol*eye(ss);
%         start timer
        tolLap_time = tic;
%         perform ldl
        if reducebandwidth
            rcm_LL = symrcm(LL);
            [l d p] = ldl(tol_LL(rcm_LL,rcm_LL));
        else
            laplTime = tic;
            [l d p] = ldl(tol_LL);
        end
%         end timer
        tolZero_times(ss,tt)=toc(tolLap_time);
%         count: within tol, greater, neg
        eigvals = diag(d);
        num_withinTol = sum(eigvals == 0);
        num_aboveTol = sum(eigvals > tol);
        num_neg = sum(eigvals < 0);
%         plot on 201; 202: the counts, expected counts; and times
        figure(201);
        subplot(3,1,1);
        plot(ss,num_withinTol,'bo');
        subplot(3,1,2);
        plot(ss,num_aboveTol,'ro');
        subplot(3,1,3);
        plot(ss,num_neg,'go');

        figure(202);
        plot(ss,tolZero_times(ss,tt),'mo');

        clear components d p l LL tol_LL eigvals
    end
end

