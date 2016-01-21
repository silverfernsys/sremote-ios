//
//  SampleData.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 12/27/15.
//  Copyright © 2015 SilverFern Systems, Inc. All rights reserved.
//

let serverData = [
    ServerData(ip: "163.128.0.1", port: "8080", stats:
        ["running": 8,
        "starting": 3,
        "restarting": 0,
        "stopping": 1,
        "stopped": 5]),
    ServerData(ip: "http://supervisor.tenix.io", port: "9900", stats:
        ["running": 2,
            "starting": 1,
            "restarting": 0,
            "stopping": 0,
            "stopped": 0]),
    ServerData(ip: "82.34.128.10", port: "6000", stats:
        ["running": 25,
            "starting": 0,
            "restarting": 0,
            "stopping": 1,
            "stopped": 6]),
    ServerData(ip: "163.198.12.2", port: "6622", stats:
        ["running": 9,
            "starting": 0,
            "restarting": 1,
            "stopping": 1,
            "stopped": 0]),
    ServerData(ip: "supervisor.opps.com", port: "7474", stats:
        ["running": 101,
            "starting": 5,
            "restarting": 2,
            "stopping": 3,
            "stopped": 9]),
    ServerData(ip: "stats.books.com", port: "8081", stats:
        ["running": 5,
            "starting": 3,
            "restarting": 1,
            "stopping": 0,
            "stopped": 8]),
    ServerData(ip: "http://stats.appnet.com", port: "8080", stats:
        ["running": 74,
            "starting": 0,
            "restarting": 0,
            "stopping": 0,
            "stopped": 1]),
    ServerData(ip: "http://appstack.io/stats", port: "80", stats:
        ["running": 0,
            "starting": 3,
            "restarting": 0,
            "stopping": 10,
            "stopped": 54]),
    ServerData(ip: "https://mapr.com/supervisor", port: "443", stats:
        ["running": 73,
            "starting": 0,
            "restarting": 0,
            "stopping": 0,
            "stopped": 0]),
    ServerData(ip: "102.23.73.23", port: "443", stats:
        ["running": 1,
            "starting": 28,
            "restarting": 10,
            "stopping": 1,
            "stopped": 5])
]