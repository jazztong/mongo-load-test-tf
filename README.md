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

| Comparison                          | EC2-1000IO1-M5.Large | Fargate-EFS | ECS EC2-1000IO1-M5.Large |
| ----------------------------------- | -------------------- | ----------- | ------------------------ |
| [OVERALL], RunTime(ms)              | 44,214               | 72,497      | 49,226                   |
| [OVERALL], Throughput(ops/sec)      | 11,308               | 6,896       | 10,157                   |
| [INSERT], AverageLatency(us)        | 8,622                | 14,022      | 9,582                    |
| [INSERT], MinLatency(us)            | 164                  | 462         | 177                      |
| [INSERT], MaxLatency(us)            | 6,426,623            | 7,913,471   | 5,701,631                |
| [INSERT], 95thPercentileLatency(us) | 22,239               | 36,223      | 25,423                   |
| [INSERT], 99thPercentileLatency(us) | 60,927               | 83,583      | 66,559                   |

### Mongo-EC2 (1000 IO1)

```
[OVERALL], RunTime(ms), 44214
[OVERALL], Throughput(ops/sec), 11308.635273895146
[TOTAL_GCS_Copy], Count, 1477
[TOTAL_GC_TIME_Copy], Time(ms), 3396
[TOTAL_GC_TIME_%_Copy], Time(%), 7.680825078029583
[TOTAL_GCS_MarkSweepCompact], Count, 6
[TOTAL_GC_TIME_MarkSweepCompact], Time(ms), 117
[TOTAL_GC_TIME_%_MarkSweepCompact], Time(%), 0.2646220654091464
[TOTAL_GCs], Count, 1483
[TOTAL_GC_TIME], Time(ms), 3513
[TOTAL_GC_TIME_%], Time(%), 7.94544714343873
[CLEANUP], Operations, 100
[CLEANUP], AverageLatency(us), 50.18
[CLEANUP], MinLatency(us), 0
[CLEANUP], MaxLatency(us), 4867
[CLEANUP], 95thPercentileLatency(us), 8
[CLEANUP], 99thPercentileLatency(us), 13
[INSERT], Operations, 500000
[INSERT], AverageLatency(us), 8622.01634
[INSERT], MinLatency(us), 164
[INSERT], MaxLatency(us), 6426623
[INSERT], 95thPercentileLatency(us), 22239
[INSERT], 99thPercentileLatency(us), 60927
[INSERT], Return=OK, 500000
```

### Fargate EFS 150 MBPS

```
[OVERALL], RunTime(ms), 72497
[OVERALL], Throughput(ops/sec), 6896.837110501124
[TOTAL_GCS_Copy], Count, 1420
[TOTAL_GC_TIME_Copy], Time(ms), 2744
[TOTAL_GC_TIME_%_Copy], Time(%), 3.7849842062430166
[TOTAL_GCS_MarkSweepCompact], Count, 6
[TOTAL_GC_TIME_MarkSweepCompact], Time(ms), 114
[TOTAL_GC_TIME_%_MarkSweepCompact], Time(%), 0.15724788611942564
[TOTAL_GCs], Count, 1426
[TOTAL_GC_TIME], Time(ms), 2858
[TOTAL_GC_TIME_%], Time(%), 3.9422320923624423
[CLEANUP], Operations, 100
[CLEANUP], AverageLatency(us), 32.11
[CLEANUP], MinLatency(us), 0
[CLEANUP], MaxLatency(us), 3067
[CLEANUP], 95thPercentileLatency(us), 2
[CLEANUP], 99thPercentileLatency(us), 14
[INSERT], Operations, 500000
[INSERT], AverageLatency(us), 14022.777956
[INSERT], MinLatency(us), 462
[INSERT], MaxLatency(us), 7913471
[INSERT], 95thPercentileLatency(us), 36223
[INSERT], 99thPercentileLatency(us), 83583
[INSERT], Return=OK, 500000
```

### ECS

```
[OVERALL], RunTime(ms), 49226
[OVERALL], Throughput(ops/sec), 10157.233982042011
[TOTAL_GCS_Copy], Count, 1429
[TOTAL_GC_TIME_Copy], Time(ms), 3180
[TOTAL_GC_TIME_%_Copy], Time(%), 6.460000812578719
[TOTAL_GCS_MarkSweepCompact], Count, 7
[TOTAL_GC_TIME_MarkSweepCompact], Time(ms), 131
[TOTAL_GC_TIME_%_MarkSweepCompact], Time(%), 0.26611953032950064
[TOTAL_GCs], Count, 1436
[TOTAL_GC_TIME], Time(ms), 3311
[TOTAL_GC_TIME_%], Time(%), 6.726120342908219
[CLEANUP], Operations, 100
[CLEANUP], AverageLatency(us), 32.83
[CLEANUP], MinLatency(us), 0
[CLEANUP], MaxLatency(us), 3181
[CLEANUP], 95thPercentileLatency(us), 2
[CLEANUP], 99thPercentileLatency(us), 6
[INSERT], Operations, 500000
[INSERT], AverageLatency(us), 9582.214368
[INSERT], MinLatency(us), 177
[INSERT], MaxLatency(us), 5701631
[INSERT], 95thPercentileLatency(us), 25423
[INSERT], 99thPercentileLatency(us), 66559
[INSERT], Return=OK, 500000
```
