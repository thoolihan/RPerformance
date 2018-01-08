.PHONY: download

download: 
	wget https://github.com/arunsrinivasan/flights/wiki/NYCflights14/flights14.csv -O data/flights14.csv
	wget http://archive.ics.uci.edu/ml/machine-learning-databases/00344/Activity%20recognition%20exp.zip -O "data/Activity recognition exp.zip"
	wget http://archive.ics.uci.edu/ml/machine-learning-databases/00344/Still%20exp.zip -O "data/Still exp.zip"


