|%
::  agent state:
::    next-ticket-id=@ud
::    next-comment-id=@ud
::    next-label-id=@ud
::    boards=(map desk:clay board)
::    labels=(set label)
::
::  Most of these structures include fields which we don't intend to use
::  yet, but which will be helpful in the future, and so we prefer to
::  have them in the state as early as possible. These fields will be
::  marked RFU, or Reserved for Future Use.
+$  board
  $:  =desk
      tickets=(map @ud ticket)
      date-created=@da
      date-updated=@da
    ::  RFU
      admins=(set @p)
      editors=(set @p)
      viewers=(set @p)
  ==
::
::  tickets
+$  ticket
  $:  id=@ud
      title=@t
      body=@t
      author=@p
      =ticket-type
      =app-version
      date-created=@da
      date-updated=@da
    ::  RFU
      priority=ticket-priority
      labels=(set label)
      date-resolved=(unit @da)
      comments=(map @ud comment)
      :: thread=(list (pair ship time)) :: talk dms
  ==
+$  ticket-type
  $%  %request  :: feature request
      %support  :: support request
      %report   :: bug report
      %document :: documentation request
      %general  :: general feedback
  ==
+$  ticket-priority
  $%  %none  :: new ticket, not evaluated
      %low
      %medium
      %high
      %urgent
  ==
+$  ticket-status
  $%  %new
      %in-progress
      %resolved
      %dropped
  ==
+$  app-version
  [major=@ud minor=@ud patch=@ud]
::
::  labels
+$  label
  $:  text=@t  ::  less than 40 characters
      id=@ud
      date-created=@da
      date-updated=@da
    ::  RFU
      color=@t
      emoji=@t
  ==
::
+$  comment
  $:  id=@ud
      body=@t
      author=@p
      date-created=@da
      date-updated=@da
    ::  RFU
      reply-to=@ud
  ==
::
::  actions
+$  pharos-action
  $%  $:  %create-board
          =desk
      ==
      $:  %create-ticket
          =desk
          title=@t
          body=@t
          author=@p
          anon=?
          =app-version
          =ticket-type
      ==
      $:  %delete-ticket
          id=@ud
          =desk
  ==  ==
--
