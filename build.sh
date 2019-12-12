docker build -t gcr.io/green-buttress-260810/expo:alpha-v0.3 .

docker rm -f green 
docker push gcr.io/green-buttress-260810/expo:alpha-v0.3 
docker run --name green -d -p 80:80 gcr.io/green-buttress-260810/expo:alpha-v0.3
docker ps

#if [[ "$(docker ps -a > /dev/null)" == "" ]]; then
  # do something
#fi
