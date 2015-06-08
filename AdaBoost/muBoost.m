close all;
clear all
load Tss.mat
tic;

% data  = X_train(1:300,:);
% label = Y_train(1:300,:);
data  = X_train;
label = Y_train;
% addBoost

T = 25; % we choose maximally T weak learners (weak classifiers)
D = ones(size(label))/length(label); % initial weight is equal weight for all samples
h = {}; % will hold weak classifiers
alpha = []; % weight of each weak learner (not weight of sample)

for t=1:T
    err(t) = inf;
    thresholds = [0:0.3:11.6];
    for ii=1:length(thresholds) %threshold
        for jj=[-1 1] %direction
            for kk=[1:1:length(data(1,:))] %dim
                tmph.dim = kk;
                tmph.pos = jj;
                tmph.threshold  = thresholds(ii);
                tmpe = sum(D.*(weakLearner(tmph,data) ~= label));
                if(tmpe < err(t))
                    err(t) = tmpe;
                    h{t} = tmph;
                end
            end
        end
    end
    
    if(err(t) >= 1/2)
        disp('stop b/c err>1/2')
        break;
    end
    
    alpha(t) = 1/2 * log((1-err(t))/err(t));
    
    % we update D so that wrongly classified samples will have more weight
    D = D.* exp(-alpha(t).*label.* weakLearner(h{t}, data));
    D = D./sum(D);
end


% strong learner, which is simply a linear sum of weak learners. The weight
% of each weak learner is in alpha
finalLabel = zeros(size(label));
for t=1:length(alpha) %T iterations
    finalLabel = finalLabel + alpha(t) * weakLearner(h{t}, data);
    tfinalLabel = sign(finalLabel);
    misshits(t) = sum(tfinalLabel ~= label)/size(data,1);    
end

% 
% % plot miss hits when more and more weak learners are used
% figure('color','w');plot(misshits)
% ylabel('miss hists')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%TEST%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test_data  = X_test;
test_label = Y_test;
% strong learner, which is simply a linear sum of weak learners. The weight
% of each weak learner is in alpha
finalLabel = zeros(size(test_label));
for t=1:length(alpha) %T iterations
    finalLabel = finalLabel + alpha(t) * weakLearner(h{t}, test_data);
    tfinalLabel = sign(finalLabel);
    misshits1(t) = sum(tfinalLabel ~= test_label)/size(test_data,1);    
end


% % plot miss hits when more and more weak learners are used
% figure('color','w');plot(misshits1)
% ylabel('miss hists')
toc;

figure('color','w');
plot(misshits,'--rs')
hold on;
plot(misshits1,'-gs')
ylabel('Error')
xlabel('# of iterations')
legend('Train error','Test error',...
              'Location','NorthEastOutside')

hold off;
