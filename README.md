# dotdotcommadot Commands

###### Version: 0.0.1 -- alpha

## About

dotdotcommadot Commands is a light-weight commands system.  
The main goal of commands is to organise your business logic into encapsulated chunks,   
improving both readability, modularity and testability of your application.  
Commands integrate very well with all MV* patterns.

## How To: Using AsyncCommands

AsyncCommands are short-lived objects that encapsulate pieces of business logic.  
Parameters are passed through the constructor (not through the execute() method).  
On completion of the command (by calling the complete() method), a CommandResult object will be returned by the future.

### Creating an AsyncCommand

```Dart
Class LoginCommand extends AsyncCommand
{
    final String username;
    final String password;

    LoginCommand(this.username, this.password);
    
    @override
    Future<CommandResult> execute()
    {
        // execute login logic 
        
        if (myApplication.isLoggedIn)
            complete(true, 'Login succeeded);
        else
            complete(false, 'Username and password did not match');
            
        return future;
    }
}
```

### Running a Single AsyncCommand

```Dart
new LoginCommand('RenoRaines', 'Renegade4Ever').run()
    ..then((CommandResult result) => print(result.message));
```

## How To: Using the CommandRunner

A Commandrunner is an object that will run several commands in a chained way.
This means that the Commandrunner will wait for the previous AsyncCommand to complete before starting to execute the next AsyncCommand.
This is in contrast with the default Dart Futures API ```Future.wait(List<Futures> futures);```.
Here all async methods will run immediately, and the ```wait``` method will wait untill all methods are completed as batch,   
instead of waiting for each method to be completed before starting to run the next one.


### Chaining AsyncCommand with the CommandRunner

```Dart
CommandRunner runner = new CommandRunner();
runner.addAll(
[
    new LoginCommand('RenoRaines', 'Renegade4Ever'),
    new UpdateCookiesCommand()
]);

runner.run()
    ..then((List<CommandResult> results) => results.forEach((result) => print(result.message)));
```

## How To: Using Hooks

Hooks are objects that will be executed right before the command they are related to is being executed.  
Their main purpose is to perform tasks that are related to the command, but you might not regard as business logic.  
Seperating the actions performed by a hook from their related command to will often times clean up your unit tests, 
since you will only be testing what is really relevant for that command.  
A good use for a hook would be to update a progressbar, or reinitialize a list of items.  
Or, as in our example, to update the number of login attempts when you don't want the LoginCommand to have a dependency on the ```myApplcation``` object.

### Creating a Hook

```Dart
Class UpdateLoginAttemptsHook extends Hook
{
    Future execute()
    {
        myApplication.loginAttempts += 1;
        
        complete();
        return future;
    }
}
```

### Running a Single AsyncCommand with a Hook

```Dart
new LoginCommand('RenoRaines', 'Renegade4Ever')
    ..withHooks([new UpdateLoginAttemptsHook()])
    ..run()
    ..then((CommandResult result) => print(result.message));
```

## How To: Using Guards

Guards are objects that will be executed __before__ the hooks and the related command is being executed.
The purpose of a guard is to check for certain conditions, and return a flag allowing the command either to run or not.
In our example, a good use for a guard would be to check whether the number of max login attempts is reached.

### Creating a Guard

```Dart
Class CheckForMaxLoginAttemptsReachedGuard extends Guard
{
    bool execute()
    {
        if (myApplication.loginAttempts == myApplication.maxLoginAttempts)
            return false;
        else
            return true;
    }
}
```

### Running a Single AsyncCommand with a Guard

```Dart
new LoginCommand('RenoRaines', 'Renegade4Ever')
    ..withHooks([new UpdateLoginAttemptsHook()])
    ..withGuards([new CheckForMaxLoginAttemptsReachedGuard()])
    ..run()
    ..then((CommandResult result) => print(result.message));
```

## Info
	
For more info about this project, contact:

- [hans@dotdotcommadot.com](mailto:hans@dotdotcommadot.com)