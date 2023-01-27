module ConfidenceInterval

using Statistics
using Distributions

export student, confidence_interval

"Gives the Student coefficient corresponding to a confidence interval of `confidence` (∈ [0,1]) for a measurement repeated `n` times."
function student(n,confidence)
	return quantile(TDist(n-1), confidence+(1-confidence)/2)
end

"Returns the confidence interval corresponding to a confidence interval of `confidence` (∈ [0,1]) as 2-element vector for the list of measured values `meas`."
function confidence_interval(meas, confidence)
	l = length(meas)
	avg = mean(meas)
	dev = std(meas)
	uncertainty = dev/l^.5
	k = student(l, confidence)
	broad_unc = k*uncertainty
	return [avg-broad_unc, avg+broad_unc]
end

end
