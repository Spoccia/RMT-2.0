% Plot the Motifs on the data
% Silvestro Roberto Poccia & Sicong Liu
%
% plot_motif_on_data(data, sub_len, motif_idx, motif_dim)
%
% Input:
%     data: input time series (matrix)
%     motif_idx: the index for the founded motifs (matrix)
%     motif_dim: the dimensions spanned by the found motifs (cell)
%     motif_lenght: the lenght in time of each motif (array)
%
%

function figure1 = plot_RMTmotif_on_data(data, motif_idx, motif_dim,motif_lenght)
figure1=figure();
ax = axes();
hold(ax, 'on');
data =data';
%% plot the data
for i = 1:size(data, 2)
    data(:, i) = data(:, i) - min(data(:, i));
    data(:, i) = data(:, i) / max(data(:, i));
    data(:, i) = data(:, i) + (i - 1) * 1.1;
    plot(data(:, i), 'color', 'k');
end

for i = 1:length(motif_idx)
    for k = 1:length(motif_dim{i})
        sub_len=motif_lenght{i};
        motif_location = motif_idx(i):motif_idx(i) + sub_len - 1;
        motif = data(motif_location, motif_dim{i}(k));
        plot(motif_location, motif, 'color', 'r');
    end
end

hold(ax, 'off');