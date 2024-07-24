import 'dart:math';

void main() {
  List<int> teams = List.generate(6, (index) => index + 1); // Generates teams from 1 to 20
  List<List<String>> schedule = generateRoundRobinSchedule(teams);

  printSchedule(schedule);
}

List<List<String>> generateRoundRobinSchedule(List<int> teams) {
  int numTeams = teams.length;
  List<List<String>> homeRounds = [];
  List<List<String>> awayRounds = [];
  Random random = Random();
  
  // Generate home matches
  for (int i = 0; i < numTeams - 1; i++) {
    List<int> homeTeams = List.from(teams);
    homeTeams.shuffle(random); // Randomly shuffle teams
    
    List<String> roundMatches = [];
    for (int j = 0; j < numTeams ~/ 2; j++) {
      int team1 = homeTeams[j];
      int team2 = homeTeams[homeTeams.length - j - 1];
      roundMatches.add('$team1 vs $team2');
    }

    homeRounds.add(roundMatches);
    // Rotate teams for next round
    teams = [teams.last] + teams.sublist(0, teams.length - 1);
  }
  
  // Generate away matches by swapping team positions
  for (List<String> round in homeRounds) {
    awayRounds.add(round.map((match) {
      var parts = match.split(' vs ');
      return '${parts[1]} vs ${parts[0]}'; // Swap home and away
    }).toList());
  }

  // Combine home and away rounds
  List<List<String>> fullSchedule = [];
  for (int i = 0; i < homeRounds.length; i++) {
    fullSchedule.add(homeRounds[i]);  // Home games
  }
  for (int i = 0; i < awayRounds.length; i++) {
    fullSchedule.add(awayRounds[i]);  // Away games
  }

  return fullSchedule;
}

void printSchedule(List<List<String>> schedule) {
  int roundNumber = 1;
  for (List<String> roundMatches in schedule) {
    print('Round ${roundNumber++}:');
    for (String match in roundMatches) {
      print(match);
    }
    print("");
  }
}
