# MMLM-2017
Predict the 2017 NCAA Basketball Tournament

Introduction
------------

The objective is to predict probabilities for every possible matchup in the past 4 NCAA tournaments (2013-2016).
This is my first project using a programming language to manipulate data. I'd never programmed on a professional project before, so in these 4 days I tried really hard to learn and complete this task. 
I'm coming from "Digital Analysis" where I've worked with Google Analytics, Adobe Analytics, adwords, website and url tracking… and now my goal is move forward to become a Data Analyst in the future, who works with programming languages and tools to analyse data. 

Difficulties on the way
-----------------------

 * My knowledge and my experience in R are very limited, all this is   
   from what I've learned at the Datacamp "Introduction to R",   
   "Exploratory Data Analysis" and in some searches at   
   google/stackoverflow.  So I know that my codes are far from perfect, 
   but I needed to show my effort to learn and put the things on.
 * To understand the project. I know nothing about Basketball, so I
   needed to search about this sport and about the specific "NCAA
   Basketball Tournament" and their rules. E.g. What are Seeds? How it
   could impact the final results?

Understanding input CSVs from Kaggle
------------------------------------

 * **sample_submission.csv:** is the document that we need to import our predictions. Has this 2 columns:
			*Id:* e.g. 2013 is the year, 1103 is the team A and 1107 is the team B.
			*Pred:* This 0.5 represents the chance of Team A have to win the Team B. So, they start with 50% of chance each.

![sample_submission.csv][1]

* **TourneyCompactResults.csv:** In this document we will focus in 3 elements
			*Season:* Indicates the year in which the tournament was played. 
			*Wteam:* Identifies the id number of the team that won the game.
			*Lteam:* Identifies the id number of the team that lost the game.

![enter image description here][2]

Hypothesis
----------

	
Based on the results on TourneyCompactResults.csv file and having TourneySeeds.csv file to help, I started with 2 main theories that will be the key for our prediction results. They are:

* *Seeds difference*

Most of the winner teams were in a better (smaller) seed than the loser teams. And the bigger the seed difference, most likely the team with a better seed will win.

* *Win rate difference*

In most cases, a team with a better win rate is most likely to win a game than a team with a smaller win rate.


Results from hypothesis
-----------------------

* *Seeds difference*

		GRAFICO 1

		GRAFICO 2

*Conclusion:* From a total of 2050 games played from 1985 to 2016, 70% of the games had a winner with a better (smaller) seed, comparing to the loser team.

* *Win rate difference*
		
		GRAFICO 1

		GRAFICO 2

*Conclusion:* From a total of 2050 games played from 1985 to 2016, 73% of the games had a winner with a better (higher) win rate, comparing to the loser team.


Generating the prediction file
------------------------------

Now we know that seeds and win rate affect the result of a match. So let's calculate what should be their impact on the final predict value.
First, we need to find the biggest possible variation between the two variables (seed difference and win rate difference between team A and B):

Max Seed difference = 15 (When team A seed is 1 and team B is 16)
Max win rate difference = 100 (When team A Win rate is 100% and B is 0%)

Seed difference coeficient: 0.25 / 15 = 0.016
Win rate difference coeficient: 0.25 / 100 = 0.0025

Base prediction from sample_submission.csv: 0.5
Max possible prediction: 0.5 + 0.25 + 0.25 = 1.0
Min possible prediction: 0.5 - 0.25 - 0.25 = 0.0

Prediction output sample
------------------------

![Prediction output sample][3]


  [1]: https://cloud.githubusercontent.com/assets/4197248/23638280/9ebaa90e-02ae-11e7-8458-6e92d89485f5.png
  [2]: https://cloud.githubusercontent.com/assets/4197248/23638281/9ebcd3f0-02ae-11e7-8df8-b38ee80b673f.png
  [3]: https://cloud.githubusercontent.com/assets/4197248/23638279/9eb96fda-02ae-11e7-8236-14ed5532eda8.png
