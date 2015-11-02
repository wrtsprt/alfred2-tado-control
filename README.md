# Alfred2 Workflow for controlling a Tado° Smart Thermostat

[Alfred2](https://www.alfredapp.com) workflow that allows to retrieve certain information
(and change certain settings about the [Tado° Smart Thermostat](https://www.tado.com/)).

* retrieves current temperature and shows heating status
* with modifier key CMD opens Tado° home control website

## TODO:

* change mode: off, manual, auto
* show current destination

## Setting up credentials

Your credentials for the Tado° API are safely stored inside the OS X keychain.
To do this open Keychain Access (open spotlight, type Keychain). Select the `login` keychain.
Click the plus on the bottom to add an account.

Keychain item name: tado-api
Account Name: <yourtadousername>
Password: <yourtadopassword>

Click `Add`.

Now open your terminal an call `security find-generic-password -l tado-api -w` once. This will
attempt to retrieve your password from Keychain and will popup the permissions dialog. Pleaes select
`Always allow`, for the workflow to be able to retrieve the credentails later on.

# Thanks

* https://github.com/zhaocai for alfred2-ruby-template and the alfred-workflow gem
* Dimitri König for https://www.dimitrikoenig.net/better-usage-of-sensible-user-data-for-alfred-workflows.html
