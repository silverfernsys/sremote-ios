//
//  SampleData.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 12/27/15.
//  Copyright © 2015 - 2016 SilverFern Systems, Inc. All rights reserved.
//

//"stopped": 4,
//"starting": 2,
//"running": 9,
//"backoff": 0,
//"stopping": 1,
//"exited": 3,
//"fatal": 2,
//"unknown": 0

let serverData = [
    Server(id: nil, sort_id: nil, ip: "192.168.33.10", port: 8080, hostname: "v64", connection_scheme: "http", num_cores: 8, num_stopped: 4, num_starting: 2, num_running: 9, num_backoff: 1, num_stopping: 2, num_exited: 3, num_fatal: 2, num_unknown: 0)
]
/*
let serverData = [
    ServerData(ip: "163.128.0.1", port: "8080", stats:
        ["stopped": 4,
            "starting": 2,
            "running": 9,
            "backoff": 0,
            "stopping": 1,
            "exited": 3,
            "fatal": 2,
            "unknown": 0]),
    ServerData(ip: "http://supervisor.tenix.io", port: "9900", stats:
        ["stopped": 4,
            "starting": 2,
            "running": 9,
            "backoff": 0,
            "stopping": 1,
            "exited": 3,
            "fatal": 2,
            "unknown": 0]),
    ServerData(ip: "82.34.128.10", port: "6000", stats:
        ["stopped": 4,
            "starting": 2,
            "running": 9,
            "backoff": 0,
            "stopping": 1,
            "exited": 3,
            "fatal": 2,
            "unknown": 0]),
    ServerData(ip: "163.198.12.2", port: "6622", stats:
        ["stopped": 4,
            "starting": 2,
            "running": 9,
            "backoff": 0,
            "stopping": 1,
            "exited": 3,
            "fatal": 2,
            "unknown": 0]),
    ServerData(ip: "supervisor.opps.com", port: "7474", stats:
        ["stopped": 4,
            "starting": 2,
            "running": 9,
            "backoff": 0,
            "stopping": 1,
            "exited": 3,
            "fatal": 2,
            "unknown": 0]),
    ServerData(ip: "stats.books.com", port: "8081", stats:
        ["stopped": 4,
            "starting": 2,
            "running": 9,
            "backoff": 0,
            "stopping": 1,
            "exited": 3,
            "fatal": 2,
            "unknown": 0]),
    ServerData(ip: "http://stats.appnet.com", port: "8080", stats:
        ["stopped": 4,
            "starting": 2,
            "running": 9,
            "backoff": 0,
            "stopping": 1,
            "exited": 3,
            "fatal": 2,
            "unknown": 0]),
    ServerData(ip: "http://appstack.io/stats", port: "80", stats:
        ["stopped": 4,
            "starting": 2,
            "running": 9,
            "backoff": 0,
            "stopping": 1,
            "exited": 3,
            "fatal": 2,
            "unknown": 0]),
    ServerData(ip: "https://mapr.com/supervisor", port: "443", stats:
        ["stopped": 4,
            "starting": 2,
            "running": 9,
            "backoff": 0,
            "stopping": 1,
            "exited": 3,
            "fatal": 2,
            "unknown": 0]),
    ServerData(ip: "102.23.73.23", port: "443", stats:
        ["stopped": 4,
            "starting": 2,
            "running": 9,
            "backoff": 0,
            "stopping": 1,
            "exited": 3,
            "fatal": 2,
            "unknown": 0])
]
*/