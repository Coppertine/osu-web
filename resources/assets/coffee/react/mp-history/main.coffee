###
# Copyright 2016 ppy Pty. Ltd.
#
# This file is part of osu!web. osu!web is distributed with the hope of
# attracting more community contributions to the core ecosystem of osu!.
#
# osu!web is free software: you can redistribute it and/or modify
# it under the terms of the Affero GNU General Public License version 3
# as published by the Free Software Foundation.
#
# osu!web is distributed WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with osu!web.  If not, see <http://www.gnu.org/licenses/>.
###
{div} = React.DOM

class MPHistory.Main extends React.Component
  timeBetweenRefresh = 10000

  constructor: (props) ->
    super props

    @state =
      endTime: props.end_time
      name: name
      events: []
      since: 0

    @loadHistory @state.since

  loadHistory: =>
    $.ajax laroute.route('multiplayer.match.history', match_id: @props.match.id),
      method: 'GET'
      dataType: 'JSON'
      data:
        since: @state.since

    .done (data) =>
      newEvents = _.concat @state.events, data.data

      @setState
        events: newEvents
        since: _.last(newEvents).id
        => _.delay @loadHistory, timeBetweenRefresh

  printEvents: =>
    console.log @state.events

  render: ->
    div className: 'osu-layout__section',
      div className: 'osu-layout__row osu-layout__row--page-mp-history'
