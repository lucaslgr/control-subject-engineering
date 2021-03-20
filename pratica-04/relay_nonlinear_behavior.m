%Gerando o gráfico que representa o comportamento não linear do Rele Ideal

figure
hold on
h1 = plot(-5:0.001:0, 1*ones(1, 5001), 'b')
h2 = plot(0:0.001:5, 2*ones(1, 5001), 'b')
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(h1, 'linewidth', 2)
set(h2, 'linewidth', 2)
xlabel('Entrada')
ylabel('Saída')
axis([-5 5  -1 2.5])
hold off