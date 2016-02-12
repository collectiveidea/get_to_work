# get\_to\_work
get\_to\_work tags your Harvest time entries with information from Pivotal Tracker, *from your command line.*

No more tab twiddling to do this task in the browser.

## Installation
```shell
gem install get_to_work
```

## Workflow

### Bootstrap your project's directory
get\_to\_work needs to know how to talk to your services (Harvest and Pivotal Tracker). So each of your project's working directories need to be bootstrapped:

```shell
get-to-work bootstrap
```

This command will:

* Save your credentials to the OSX keychain
* Bookmark your Pivotal Tracker and Harvest projects in a `.get-to-work` file


### Start working on a story
```shell
get-to-work start [pivotal_tracker_story_url]
```

This command pulls information from Pivotal Tracker and saves it in your new timer's notes including:

* Pivotal Tracker ID hashtag
* Pivotal Tracker story name
* Pivotal Tracker URL

### Stop working on a story
```shell
get-to-work stop
```

Stops the current timer started by get\_to\_work.