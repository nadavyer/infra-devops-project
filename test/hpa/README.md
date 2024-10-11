To run a load test on the service you can run the follwing
```bash
brew install httpd
ab -n 10000 -c 200 http://nadav-proj-cluster-ext-alb-1530607942.us-east-2.elb.amazonaws.com/testing
```