//
//  SampleData.swift
//  SupervisorRemote
//
//  Created by Marc Wilson on 12/27/15.
//  Copyright © 2015 - 2016 SilverFern Systems, Inc. All rights reserved.
//

let serverData = [
    Server(id: nil, sort_id: nil, ip: "192.168.33.10", port: 8080, hostname: "v64", connection_scheme: "http", num_cores: 8, num_stopped: 500, num_starting: 200, num_running: 999, num_backoff: 330, num_stopping: 87, num_exited: 300, num_fatal: 2, num_unknown: 0),
    Server(id: nil, sort_id: nil, ip: "84.18.235.209", port: 8081, hostname: "wiley64", connection_scheme: "https", num_cores: 8, num_stopped: 1, num_starting: 2, num_running: 7, num_backoff: 0, num_stopping: 0, num_exited: 1, num_fatal: 4, num_unknown: 0),
    Server(id: nil, sort_id: nil, ip: "192.168.33.10", port: 8080, hostname: "v64", connection_scheme: "http", num_cores: 8, num_stopped: 4, num_starting: 2, num_running: 9, num_backoff: 1, num_stopping: 2, num_exited: 3, num_fatal: 2, num_unknown: 0),
    Server(id: nil, sort_id: nil, ip: "84.18.235.209", port: 8081, hostname: "wiley64", connection_scheme: "https", num_cores: 8, num_stopped: 1, num_starting: 2, num_running: 7, num_backoff: 0, num_stopping: 0, num_exited: 1, num_fatal: 4, num_unknown: 0),
    Server(id: nil, sort_id: nil, ip: "192.168.33.10", port: 8080, hostname: "v64", connection_scheme: "http", num_cores: 8, num_stopped: 4, num_starting: 2, num_running: 9, num_backoff: 1, num_stopping: 2, num_exited: 3, num_fatal: 2, num_unknown: 0),
    Server(id: nil, sort_id: nil, ip: "84.18.235.209", port: 8081, hostname: "wiley64", connection_scheme: "https", num_cores: 8, num_stopped: 1, num_starting: 2, num_running: 7, num_backoff: 0, num_stopping: 0, num_exited: 1, num_fatal: 4, num_unknown: 0),
    Server(id: nil, sort_id: nil, ip: "192.168.33.10", port: 8080, hostname: "v64", connection_scheme: "http", num_cores: 8, num_stopped: 4, num_starting: 2, num_running: 9, num_backoff: 1, num_stopping: 2, num_exited: 3, num_fatal: 2, num_unknown: 0),
    Server(id: nil, sort_id: nil, ip: "84.18.235.209", port: 8081, hostname: "wiley64", connection_scheme: "https", num_cores: 8, num_stopped: 1, num_starting: 2, num_running: 7, num_backoff: 0, num_stopping: 0, num_exited: 1, num_fatal: 4, num_unknown: 0),
    Server(id: nil, sort_id: nil, ip: "192.168.33.10", port: 8080, hostname: "v64", connection_scheme: "http", num_cores: 8, num_stopped: 4, num_starting: 2, num_running: 9, num_backoff: 1, num_stopping: 2, num_exited: 3, num_fatal: 2, num_unknown: 0),
    Server(id: nil, sort_id: nil, ip: "84.18.235.209", port: 8081, hostname: "wiley64", connection_scheme: "https", num_cores: 8, num_stopped: 1, num_starting: 2, num_running: 7, num_backoff: 0, num_stopping: 0, num_exited: 1, num_fatal: 4, num_unknown: 0),
    Server(id: nil, sort_id: nil, ip: "192.168.33.10", port: 8080, hostname: "v64", connection_scheme: "http", num_cores: 8, num_stopped: 4, num_starting: 2, num_running: 9, num_backoff: 1, num_stopping: 2, num_exited: 3, num_fatal: 2, num_unknown: 0),
    Server(id: nil, sort_id: nil, ip: "84.18.235.209", port: 8081, hostname: "wiley64", connection_scheme: "https", num_cores: 8, num_stopped: 1, num_starting: 2, num_running: 7, num_backoff: 0, num_stopping: 0, num_exited: 1, num_fatal: 4, num_unknown: 0),
    Server(id: nil, sort_id: nil, ip: "192.168.33.10", port: 8080, hostname: "v64", connection_scheme: "http", num_cores: 8, num_stopped: 4, num_starting: 2, num_running: 9, num_backoff: 1, num_stopping: 2, num_exited: 3, num_fatal: 2, num_unknown: 0),
    Server(id: nil, sort_id: nil, ip: "84.18.235.209", port: 8081, hostname: "wiley64", connection_scheme: "https", num_cores: 8, num_stopped: 1, num_starting: 2, num_running: 7, num_backoff: 0, num_stopping: 0, num_exited: 1, num_fatal: 4, num_unknown: 0)
]

let processData = [
    Process(id: nil, sort_id: nil, group: "sremote", name: "sremote", pid: nil, state: Int64(Constants.ProcessStates.BACKOFF), start: 1234.456, cpu: pointArray("aapl"), memory: pointArray("crm"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "qwerqwerqwerqwerqwerqqwer", name: "qwerqwerqwerqwerqwerqqwer", pid: nil, state: Int64(Constants.ProcessStates.EXITED), start: 1234.1234, cpu: pointArray("orcl"), memory: pointArray("msft"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "edgeserv", name: "edgeserv", pid: nil, state: Int64(Constants.ProcessStates.FATAL), start: nil, cpu: pointArray("yhoo"), memory: pointArray("adbe"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "token_auth", name: "token_auth", pid: nil, state: Int64(Constants.ProcessStates.RUNNING), start: 1234.1234, cpu: pointArray("amd"), memory: pointArray("armh"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "postgres", name: "postgres", pid: nil, state: Int64(Constants.ProcessStates.STARTING), start: nil, cpu: pointArray("asuuy"), memory: pointArray("atml"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "rabbitmq", name: "rabbitmq", pid: nil, state: Int64(Constants.ProcessStates.STOPPED), start: 12341234.1234, cpu: pointArray("azddq"), memory: pointArray("brcm"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "celeryd", name: "celeryd", pid: nil, state: Int64(Constants.ProcessStates.STOPPING), start: nil, cpu: pointArray("caj"), memory: pointArray("ddaif"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "soffice", name: "soffice", pid: nil, state: Int64(Constants.ProcessStates.UNKNOWN), start: nil, cpu: pointArray("emc"), memory: pointArray("fb"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "sremote", name: "sremote", pid: nil, state: Int64(Constants.ProcessStates.RUNNING), start: 1234.1234, cpu: pointArray("ge"), memory: pointArray("gm"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "cowpatty", name: "cowpatty", pid: nil, state: Int64(Constants.ProcessStates.RUNNING), start: 1234.1234, cpu: pointArray("gsit"), memory: pointArray("hpq"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "edgeserv", name: "edgeserv", pid: nil, state: Int64(Constants.ProcessStates.FATAL), start: nil, cpu: pointArray("ibm"), memory: pointArray("intc"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "token_auth", name: "token_auth", pid: nil, state: Int64(Constants.ProcessStates.RUNNING), start: 1234.1234, cpu: pointArray("issi"), memory: pointArray("lnvgy"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "postgres", name: "postgres", pid: nil, state: Int64(Constants.ProcessStates.RUNNING), start: 5643.657, cpu: pointArray("mu"), memory: pointArray("nvda"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "rabbitmq", name: "rabbitmq", pid: nil, state: Int64(Constants.ProcessStates.STOPPED), start: 12341234.1234, cpu: pointArray("qcom"), memory: pointArray("race"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "celeryd", name: "celeryd", pid: nil, state: Int64(Constants.ProcessStates.STOPPING), start: nil, cpu: pointArray("rmbs"), memory: pointArray("sndk"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "soffice", name: "soffice", pid: nil, state: Int64(Constants.ProcessStates.RUNNING), start: 85434.94, cpu: pointArray("sne"), memory: pointArray("szkmy"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "portarmor", name: "portarmor", pid: nil, state: Int64(Constants.ProcessStates.STARTING), start: nil, cpu: pointArray("tsla"), memory: pointArray("txn"), server_id: nil),
    Process(id: nil, sort_id: nil, group: "sremote_e", name: "sremote_e", pid: nil, state: Int64(Constants.ProcessStates.RUNNING), start: 85434.94, cpu: pointArray("vz"), memory: pointArray("xrx"), server_id: nil)
]