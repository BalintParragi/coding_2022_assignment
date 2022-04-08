home_team = ["LAC","GSW","GSW","PHO","LAC","LAL","SAC"]
away_team = ["GSW","PHO","LAL","SAC","LAL","PHO","GSW"]

point_diff = [-10,15,4,-8,22,5,-26]
#Points of home team minus points of away team 

def match_result(match_rank):
    if(match_rank>len(point_diff)):
        return "Pick a smaller number"
    if(point_diff[match_rank-1]>0):
        return print("The winner is",home_team[match_rank-1])
    if(point_diff[match_rank-1]<0):
        return print("The winner is",away_team[match_rank-1])
    else:
        return "No idea"

for x in range(1, 8):
  match_result(x)



