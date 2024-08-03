# Balun

A simple Flutter application for football scores.

## API Documentation
[Link] (https://www.api-football.com/documentation-v3)

# Screens

### `MatchScreen`

* Tapping team icon can open `TeamScreen`
* Tapping big score will open expanded list with values in fixture -> score
* Tabs
    * Fixture info
    * Standings - another API call
        * Streak - color code it
    * Events
    * Lineups
    * Head to head - another API call
    * Statistics
    * Players statistics
        * Dodaj ocjene pored imena igrača
            * Zeleno - > 7.0
            * Žuto - < 7.0 && > 6.5
            * Narančasto - < 6.5 && > 5.5
            * Crveno - < 5.5
        * Kartoni
            * Ako ima žuti, stavi ikonu žutog
            * Ako ima dva žuta, dva mala žuta i veći crveni
            * Ako ima crveni, stavi ikonu crvenog
        * Golovi
            * Ako je jedan, samo jedna ikona lopte
            * Ako su dva ili više, ikona lopte i mali broj golova iznad
        * Asistencije
            * Ako je jedna, samo jedna ikona asistencije
            * Ako su dvije ili više, ikona asistencije i mali broj asistencija iznad
        * Izmjene
            * Ako je izašao, ikonica izlaska
            * Ako je ušao, ikonica ulaska


### `TeamScreen`

* Team by ID
* Leagues by team API
* Standings from team
* Coachs from team
* Players from team
* Transfers team

### `LeagueScreen`

* League by ID
* Teams by league ID and season
* Standings from league ID and season
* Fixtures from league ID and season -> sort by round
* Top scorers from league ID and season
* Top assists from league ID and season
* Top yellow cards from league ID and season
* Top red cards from league ID and season

### `FixturesScreen`

* Show fixtures by date

### `PlayerScreen`

* Player from ID and season
* Injuries from player and season
* Transfers player
* Sidelined player
* Trophies player

### `CoachScreen`

* Coach from ID
* Sidelined coach
* Trophies coach
