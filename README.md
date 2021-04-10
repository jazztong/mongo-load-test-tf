# mongo-load-test-tf

Build mongo testing framework with TF and ycsb

## Run test

Run the following command when in test-client to start load test on mongo-ec2

```
cd ycsb-0.17.0
./bin/ycsb load mongodb -s -P workloads/workloada -p recordcount=500000 -threads 20 -p mongodb.url="mongodb://root:mypassword@mongo-ec2.loadtest.internel:27017/admin"
```

## Re-run

Each time run the db will create test data, to re-run require to delete db `ycsb`

## Run Summary

| Comparison                          | EC2-1000IO1-M5.Large | Fargate-EFS |
| ----------------------------------- | -------------------- | ----------- |
| [INSERT], AverageLatency(us)        | 1345.738042          | C1          |
| [INSERT], MinLatency(us)            | 157                  | C2          |
| [INSERT], MaxLatency(us)            | 1,308,671            | C3          |
| [INSERT], 95thPercentileLatency(us) | 2,881                |             |
| [INSERT], 99thPercentileLatency(us) | 6,867                |             |

### Mongo-EC2 (1000 IO1)

```
[OVERALL], RunTime(ms), 35111
[OVERALL], Throughput(ops/sec), 14240.551394149981
[TOTAL_GCS_Copy], Count, 1595
[TOTAL_GC_TIME_Copy], Time(ms), 1619
[TOTAL_GC_TIME_%_Copy], Time(%), 4.611090541425765
[TOTAL_GCS_MarkSweepCompact], Count, 0
[TOTAL_GC_TIME_MarkSweepCompact], Time(ms), 0
[TOTAL_GC_TIME_%_MarkSweepCompact], Time(%), 0.0
[TOTAL_GCs], Count, 1595
[TOTAL_GC_TIME], Time(ms), 1619
[TOTAL_GC_TIME_%], Time(%), 4.611090541425765
[CLEANUP], Operations, 20
[CLEANUP], AverageLatency(us), 94.75
[CLEANUP], MinLatency(us), 0
[CLEANUP], MaxLatency(us), 1865
[CLEANUP], 95thPercentileLatency(us), 7
[CLEANUP], 99thPercentileLatency(us), 1865
[INSERT], Operations, 500000
[INSERT], AverageLatency(us), 1345.738042
[INSERT], MinLatency(us), 157
[INSERT], MaxLatency(us), 1308671
[INSERT], 95thPercentileLatency(us), 2881
[INSERT], 99thPercentileLatency(us), 6867
[INSERT], Return=OK, 500000
```
