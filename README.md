# Pharos notes

## Summary

Pharos is the first drop-in feedback system tailored for Urbit apps. Pharos allows developers to effortlessly collect user feedback for support and product enhancements. The Pharos agent is a centralized hub through which developers can manage feedback, categorize and prioritize requests, and trigger direct communications with end users for efficient issue resolution. In the Pharos portal, developers can comment and annotate requests as well as push requests to external issue management systems (currently GitHub issues is supported).

## Installing Pharos

The workflow for installing the Pharos agent is standard as any typical user space app in Urbit. Once installed, Pharos can be accessed in Landscape.

## Navigating the Pharos UI

### Tickets View

The tickets view will appear unpopulated until some tickets are submitted. 

#### Creating Tickets

In production, we'll receive tickets from other apps integrating `/lib/grip`, our ticket submisssion library, about which more below. In development, we can create tickets from the dojo with `|create-ticket`.

```hoon
:pharos|create-ticket 'ticket title' 'ticket body', =ticket-type %report

:: +$  ticket-type
::   $?  %request  :: feature request
::       %support  :: support request
::       %report   :: bug report
::       %document :: documentation request
::       %general  :: general feedback
::   ==
```

#### Interacting with Tickets

- The table on the left lists all submitted tickets, ordered by submission date.
- Click on a ticket to display it in the preview pane on the right.
- Each ticket has a note field which you can edit freely.
- A link below the ticket's title in the detail view will open a Talk DM with the ship who submitted the ticket.
- Another button, if Github Issues integration is configured, will export the selected ticket to Github Issues.

### Settings View

The **Settings** tab is used to configure app settings. Currently, the only settings available are related to integration with GitHub Issues.

To export tickets to GitHub Issues, specify the repository owner, repository name, and a GitHub access token with issue creation permissions. For more information on how these fields are used, please visit the GitHub Issues documentation.

## Reading Data & Scrying Pharos

Pharos provides scry endpoints for single tickets and all stored tickets. We won't tell you how to live your life, but JSON is probably the easiest way to make use of them. 

To get the data for one ticket according to its ID:

```hoon
.^(json %gx /=pharos=/ticket/[ticket-id]/json)
```

or via browser:

```
[ship-url]/~/scry/pharos/ticket/[ticket-id].json
```

For obtaining all json data for the pharos agent:

```hoon
.^(json %gx /=pharos=/all-tickets/json)
```

or:

```
[ship-url]/~/scry/pharos/all-tickets.json
```

## The `/lib/grip` integration

`/lib/grip` is a library for developers to integrate into their apps, intended to facilitate collecting support tickets from users. 

It wraps a Gall agent to provide additional behavior: a web UI, a remote poke to submit a ticket, and automatic crash reporting! 

The library can be found at https://github.com/supercoolyun/grip, with a more detailed writeup there.
