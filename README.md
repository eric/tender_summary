# Tender Summary

Use this with cron or launchd to send summary emails of your Tender 
discussions.

It will include all pending discussions in the email.


## Installation

To install, just run:

    $ sudo gem install tender_summary


## Usage

An example crontab entry:

    0 9 * * * tender_summary -s tenderaccount -u robot@tenderaccount.com -p XXXX6zxY7b -t eric@tenderaccount.com -f 'Support <support@tenderaccount.com>'

Note: The password for the account will be visible in the system process 
table when the program is running.


## Inspiration

The styling used and inspiration was taken from the 
[Basecamp][http://www.basecamphq.com] daily summary emails. They look 
really nice.


## TODO

* Add command line option for customized view


## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.


## Copyright

Copyright (c) 2009 Eric Lindvall. See LICENSE for details.
