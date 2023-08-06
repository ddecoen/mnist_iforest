# compare the anomaly scores from Python and R
digitLabels = read.csv("labels.csv")
scoresSolitudeR = read.csv("solitudeRScores.csv")
scoresIsotreeR = read.csv("isotreeRScores.csv")
scoresPython = read.csv("pythonScores.csv")
scoresGo = read.csv("anomaly_scores_go.csv")
  
# merge the scoring data  
analyzeData <- data.frame("digitLabel" = digitLabels$digitLabel,
	"scoreSolitudeR" = scoresSolitudeR$iforestRScore.anomaly_score,
	"scoreIsotreeR" = scoresIsotreeR$isotreeRScore,
	"scorePython" = scoresPython$iforestPythonScore,
	"scoreGo" = scoresGo$anomalyScores)

# Note that distributions of anomaly scores have different shapes
# Are there hyperparameter settings that may bring the 
# Python and R results closer together?
pdf(file = "fig-python-anomaly-scores.pdf", width = 11, height = 8.5)
with(analyzeData, plot(density(scorePython)))
dev.off()

pdf(file = "fig-r-solitude-anomaly-scores.pdf", width = 11, height = 8.5)
with(analyzeData, plot(density(scoreSolitudeR)))
dev.off()

pdf(file = "fig-r-isotree-anomaly-scores.pdf", width = 11, height = 8.5)
with(analyzeData, plot(density(scoreIsotreeR)))
dev.off()

pdf(file = "fig-go-anomaly-scores.pdf", width = 11, height = 8.5)
with(analyzeData, plot(density(scoreGo)))
dev.off()

pdf(file = "fig-scatterplot-solitude-anomaly-scores.pdf", width = 11, height = 8.5)
with(analyzeData, plot(scorePython,scoreSolitudeR))
title(paste("Correlation between Python and R solitude anomaly scores:",
	as.character(round(with(analyzeData,cor(scorePython,scoreSolitudeR)),digits = 2))))
dev.off()

pdf(file = "fig-scatterplot-isotree-anomaly-scores.pdf", width = 11, height = 8.5)
with(analyzeData, plot(scorePython,scoreIsotreeR))
title(paste("Correlation between Python and R isotree anomaly scores:",
	as.character(round(with(analyzeData,cor(scorePython,scoreIsotreeR)),digits = 2))))
dev.off()

pdf(file = "fig-scatterplot-go-python-anomaly-scores.pdf", width = 11, height = 8.5)
with(analyzeData, plot(scorePython,scoreGo))
title(paste("Correlation between Python and Go anomaly scores:",
            as.character(round(with(analyzeData,cor(scorePython,scoreGo)),digits = 2))))
dev.off()

pdf(file = "fig-scatterplot-isotree-go-anomaly-scores.pdf", width = 11, height = 8.5)
with(analyzeData, plot(scoreGo,scoreIsotreeR))
title(paste("Correlation between Go and R isotree anomaly scores:",
            as.character(round(with(analyzeData,cor(scoreGo,scoreIsotreeR)),digits = 2))))
dev.off()
