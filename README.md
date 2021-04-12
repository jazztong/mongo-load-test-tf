# mongo-load-test-tf

Build mongo testing framework with TF and ycsb

## Preparation

1. Configure AWS Credential
2. Install terraform (0.14.9+)
3. Visual Studio Code (Prefer)

## Setup

After checkout the source, in the root directory run `terraform init` command.

## Plan

After init successful run plan with `terraform plan`.

## Deploy environment

Run `terraform apply --auto-approve` to provision all component

## Clean up

Run `terraform destroy --auto-approve` to clean up environment

## Run test

Use AWS SSM to connect to test-client.

### Use SSM login

Under SSM root path, change to root to get all the permission by:-

```
sudo su
```

### Load test for mongo-ec2

Run the following command when in test-client to start load test on mongo-ec2

```
cd /ycsb-0.17.0
./bin/ycsb load mongodb -s -P workloads/workloada -p recordcount=500000 -threads 100 -p mongodb.url="mongodb://root:mypassword@mongo-ec2.loadtest.internel:27017/admin"
```

### Load test for mongo-fargate

Run the following command when in test-client to start load test on mongo-fargate

```
cd /ycsb-0.17.0
./bin/ycsb load mongodb -s -P workloads/workloada -p recordcount=500000 -threads 100 -p mongodb.url="mongodb://root:mypassword@mongo-fargate.fargate.load:27017/admin"
```

### Load test for mongo-ecs

Run the following command when in test-client to start load test on mongo-ecs

```
cd /ycsb-0.17.0
./bin/ycsb load mongodb -s -P workloads/workloada -p recordcount=500000 -threads 100 -p mongodb.url="mongodb://root:mypassword@mongo-ecs.ecs.load:27017/admin"
```

## Re-run

Each time run the db will create test data, to re-run require to delete db `ycsb`

## Load Summary

| Comparison                          | EC2       | Fargate-EFS | ECS EC2   |
| ----------------------------------- | --------- | ----------- | --------- |
| [OVERALL], RunTime(ms)              | 48,170    | 74,961      | 45,572    |
| [OVERALL], Throughput(ops/sec)      | 10,379    | 6,670       | 10,971    |
| [INSERT], AverageLatency(us)        | 9,436     | 13,731      | 8,879     |
| [INSERT], MinLatency(us)            | 150       | 1,056       | 149       |
| [INSERT], MaxLatency(us)            | 6,619,135 | 18,743,295  | 6,688,767 |
| [INSERT], 95thPercentileLatency(us) | 18,207    | 28,191      | 18,639    |
| [INSERT], 99thPercentileLatency(us) | 46,047    | 67,647      | 56,287    |

### Mongo-EC2, M5.Large, 1000IO1 EBS

```
[OVERALL], RunTime(ms), 48170
[OVERALL], Throughput(ops/sec), 10379.904504878556
[TOTAL_GCS_PS_Scavenge], Count, 136
[TOTAL_GC_TIME_PS_Scavenge], Time(ms), 325
[TOTAL_GC_TIME_%_PS_Scavenge], Time(%), 0.6746937928171061
[TOTAL_GCS_PS_MarkSweep], Count, 0
[TOTAL_GC_TIME_PS_MarkSweep], Time(ms), 0
[TOTAL_GC_TIME_%_PS_MarkSweep], Time(%), 0.0
[TOTAL_GCs], Count, 136
[TOTAL_GC_TIME], Time(ms), 325
[TOTAL_GC_TIME_%], Time(%), 0.6746937928171061
[CLEANUP], Operations, 100
[CLEANUP], AverageLatency(us), 32.24
[CLEANUP], MinLatency(us), 0
[CLEANUP], MaxLatency(us), 3167
[CLEANUP], 95thPercentileLatency(us), 1
[CLEANUP], 99thPercentileLatency(us), 14
[INSERT], Operations, 500000
[INSERT], AverageLatency(us), 9436.848092
[INSERT], MinLatency(us), 150
[INSERT], MaxLatency(us), 6619135
[INSERT], 95thPercentileLatency(us), 18207
[INSERT], 99thPercentileLatency(us), 46047
[INSERT], Return=OK, 500000
```

### Fargate EFS

```
[OVERALL], RunTime(ms), 74961
[OVERALL], Throughput(ops/sec), 6670.135136937874
[TOTAL_GCS_PS_Scavenge], Count, 203
[TOTAL_GC_TIME_PS_Scavenge], Time(ms), 417
[TOTAL_GC_TIME_%_PS_Scavenge], Time(%), 0.5562892704206187
[TOTAL_GCS_PS_MarkSweep], Count, 0
[TOTAL_GC_TIME_PS_MarkSweep], Time(ms), 0
[TOTAL_GC_TIME_%_PS_MarkSweep], Time(%), 0.0
[TOTAL_GCs], Count, 203
[TOTAL_GC_TIME], Time(ms), 417
[TOTAL_GC_TIME_%], Time(%), 0.5562892704206187
[CLEANUP], Operations, 100
[CLEANUP], AverageLatency(us), 30.54
[CLEANUP], MinLatency(us), 0
[CLEANUP], MaxLatency(us), 2959
[CLEANUP], 95thPercentileLatency(us), 2
[CLEANUP], 99thPercentileLatency(us), 8
[INSERT], Operations, 500000
[INSERT], AverageLatency(us), 13731.694948
[INSERT], MinLatency(us), 1056
[INSERT], MaxLatency(us), 18743295
[INSERT], 95thPercentileLatency(us), 28191
[INSERT], 99thPercentileLatency(us), 67647
[INSERT], Return=OK, 500000
```

### ECS, M5.Large, 1000IO1 EBS

```
[OVERALL], RunTime(ms), 45572
[OVERALL], Throughput(ops/sec), 10971.64925831651
[TOTAL_GCS_PS_Scavenge], Count, 136
[TOTAL_GC_TIME_PS_Scavenge], Time(ms), 304
[TOTAL_GC_TIME_%_PS_Scavenge], Time(%), 0.6670762749056438
[TOTAL_GCS_PS_MarkSweep], Count, 0
[TOTAL_GC_TIME_PS_MarkSweep], Time(ms), 0
[TOTAL_GC_TIME_%_PS_MarkSweep], Time(%), 0.0
[TOTAL_GCs], Count, 136
[TOTAL_GC_TIME], Time(ms), 304
[TOTAL_GC_TIME_%], Time(%), 0.6670762749056438
[CLEANUP], Operations, 100
[CLEANUP], AverageLatency(us), 36.33
[CLEANUP], MinLatency(us), 0
[CLEANUP], MaxLatency(us), 3517
[CLEANUP], 95thPercentileLatency(us), 2
[CLEANUP], 99thPercentileLatency(us), 64
[INSERT], Operations, 500000
[INSERT], AverageLatency(us), 8879.413404
[INSERT], MinLatency(us), 149
[INSERT], MaxLatency(us), 6688767
[INSERT], 95thPercentileLatency(us), 18639
[INSERT], 99thPercentileLatency(us), 56287
[INSERT], Return=OK, 500000
```
