# create namespace to education org
vault namespace create education

# create child namespace training and certification under education
vault namespace create -namespace=education training
vault namespace create -namespace=education certification

# list the namesapce
vault namespace list
vault namespace list -namespace=education

