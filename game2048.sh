#!/bin/bash

#counters for game score and steps
score=0
step=0

canResume=true

#maim game array 4x4
declare -A gameArray

#array of changed element
declare -A chElArray

clear

#init gameArray
initArray(){
    for ((i=1; i <= 4 ; i++))
    do
        for ((j=1; j <= 4 ; j++))
        do
            gameArray[$i,$j]=0
        done
    done
}

#init gameArray
clearChElArray(){
    for ((i=1; i <= 4 ; i++))
    do
        for ((j=1; j <= 4 ; j++))
        do
            chElArray[$i,$j]=0
        done
    done
}

#add new tile to gameArray
setRandTile(){
    ok=false
    if [ $RANDOM -le  3268 ]
    then
        rTile=4
    else
        rTile=2
    fi
    #echo "Tile is $rTile"
    while [[ $ok != true ]]
    do
        let i=$RANDOM%4+1
        let j=$RANDOM%4+1

        if [[ ${gameArray[$i,$j]} = 0 ]]
        then
            gameArray[$i,$j]=$rTile
            #echo "tile is set"
            ok=true
        fi
    done
}

#show main game field with score and steps
showInfo(){

    clear
    echo "The 2048 game. BASH edition."
    echo "Score:$score"
    echo "Step:$step"
    echo "-------------------------"
    printf '|%5d|%5d|%5d|%5d|\n' "${gameArray[1,1]}" "${gameArray[1,2]}" "${gameArray[1,3]}" "${gameArray[1,4]}"
    echo "-------------------------"
    printf '|%5d|%5d|%5d|%5d|\n' "${gameArray[2,1]}" "${gameArray[2,2]}" "${gameArray[2,3]}" "${gameArray[2,4]}"
    echo "-------------------------"
    printf '|%5d|%5d|%5d|%5d|\n' "${gameArray[3,1]}" "${gameArray[3,2]}" "${gameArray[3,3]}" "${gameArray[3,4]}"
    echo "-------------------------"
    printf '|%5d|%5d|%5d|%5d|\n' "${gameArray[4,1]}" "${gameArray[4,2]}" "${gameArray[4,3]}" "${gameArray[4,4]}"
    echo "-------------------------"
}

#move Tiles
moveTilesUp(){
  for ((n=1; n <= 4 ; n++))  #for all array
  do
    for ((i=2; i <= 4 ; i++))
    do
        for ((j=1; j <= 4 ; j++))
        do
          #if cell empty -> copy current cell
          if [[ ${gameArray[$((i-1)),$j]} -eq 0 ]]
          then
            gameArray[$((i-1)),$j]=${gameArray[$i,$j]}
            gameArray[$i,$j]=0
          fi

          #if cell equal current cell -> add current cell
          if [[ ${gameArray[$((i-1)),$j]} -eq ${gameArray[$i,$j]} ]] && [[ ${gameArray[$((i-1)),$j]} -ne 0 ]]
          then
            if [[ ${chElArray[$((i-1)),$j]} -ne 1 && ${chElArray[$i,$j]} -ne 1 ]]
            then
              gameArray[$((i-1)),$j]=$((${gameArray[$i,$j]}+${gameArray[$i,$j]}))
              gameArray[$i,$j]=0
              chElArray[$((i-1)),$j]=1
              score=$((score+${gameArray[$((i-1)),$j]}))
            fi
          fi

        done  #j
    done  #i
  done  #n
  step=$((step+1))
  clearChElArray
}

moveTilesDown(){

  for ((n=1; n <= 4 ; n++))  #for all array
  do
    for ((i=3; i >= 1 ; i--))
    do
        for ((j=1; j <= 4 ; j++))
        do
          #if cell empty -> copy current cell
          if [[ ${gameArray[$((i+1)),$j]} -eq 0 ]]
          then
            gameArray[$((i+1)),$j]=${gameArray[$i,$j]}
            gameArray[$i,$j]=0
          fi

          #if cell equal current cell -> add current cell
          if [[ ${gameArray[$((i+1)),$j]} -eq ${gameArray[$i,$j]} ]] && [[ ${gameArray[$((i+1)),$j]} -ne 0 ]]
          then
            if [[ ${chElArray[$((i+1)),$j]} -ne 1 && ${chElArray[$i,$j]} -ne 1 ]]
            then
              gameArray[$((i+1)),$j]=$((${gameArray[$i,$j]}+${gameArray[$i,$j]}))
              gameArray[$i,$j]=0
              chElArray[$((i+1)),$j]=1
              score=$((score+${gameArray[$((i+1)),$j]}))
            fi
          fi

        done  #j
    done  #i
  done  #n
  step=$((step+1))
  clearChElArray
}

moveTilesLeft(){

  for ((n=1; n <= 4 ; n++))  #for all array
  do
    for ((j=2; j <= 4 ; j++))
    do
        for ((i=1; i <= 4 ; i++))
        do
          #if cell empty -> copy current cell
          if [[ ${gameArray[$i,$((j-1))]} -eq 0 ]]
          then
            gameArray[$i,$((j-1))]=${gameArray[$i,$j]}
            gameArray[$i,$j]=0
          fi

          #if cell equal current cell -> add current cell
          if [[ ${gameArray[$i,$((j-1))]} -eq ${gameArray[$i,$j]} ]] && [[ ${gameArray[$i,$((j-1))]} -ne 0 ]]
          then
            if [[ ${chElArray[$i,$((j-1))]} -ne 1 && ${chElArray[$i,$j]} -ne 1 ]]
            then
              gameArray[$i,$((j-1))]=$((${gameArray[$i,$j]}+${gameArray[$i,$j]}))
              gameArray[$i,$j]=0
              chElArray[$i,$((j-1))]=1
              score=$((score+${gameArray[$i,$((j-1))]}))
            fi
          fi

        done  #j
    done  #i
  done  #n
  step=$((step+1))
  clearChElArray
}

moveTilesRight(){
  for ((n=1; n <= 4 ; n++))  #for all array
  do
    for ((j=3; j >= 1 ; j--))
    do
        for ((i=1; i <= 4 ; i++))
        do
          #if cell empty -> copy current cell
          if [[ ${gameArray[$i,$((j+1))]} -eq 0 ]]
          then
            gameArray[$i,$((j+1))]=${gameArray[$i,$j]}
            gameArray[$i,$j]=0
          fi

          #if cell equal current cell -> add current cell
          if [[ ${gameArray[$i,$((j+1))]} -eq ${gameArray[$i,$j]} ]] && [[ ${gameArray[$i,$((j+1))]} -ne 0 ]]
          then
            if [[ ${chElArray[$i,$((j+1))]} -ne 1 && ${chElArray[$i,$j]} -ne 1 ]]
            then
              gameArray[$i,$((j+1))]=$((${gameArray[$i,$j]}+${gameArray[$i,$j]}))
              gameArray[$i,$j]=0
              chElArray[$i,$((j+1))]=1
              score=$((score+${gameArray[$i,$((j+1))]}))
            fi
          fi

        done  #j
    done  #i
  done  #n
  step=$((step+1))
  clearChElArray
}

#check user lose
checkEndGame(){
  #check free space
  canResume=false
  for ((i=1; i <= 4 ; i++))
  do
      for ((j=1; j <= 4 ; j++))
      do
          #echo "$i $j"
          if [[ ${gameArray[$i,$j]} -eq 0 ]]
          then
            canResume=true
            #echo "canResume = $canResume"
          fi
      done
  done
}

#Wait user input and move digit in gameArray
userStep(){
  echo "Use WASD or 8462 to move tiles"
  read -n1 -s -r key
  case $key in
    W|w|8)
        moveTilesUp
      ;;
    A|a|4)
        moveTilesLeft
      ;;
    S|s|2)
        moveTilesDown
      ;;
    D|d|6)
        moveTilesRight
      ;;
  esac
}

#----Main game loop-----
initArray

while [[ $canResume == true ]]; do

  setRandTile

  showInfo

  userStep

  checkEndGame

done

echo "You lose!!!"



#OLD CODE STORAGE
#echo; echo "Нажмите клавишу и затем клавишу Return."
#read Keypress


#gameArray[1,3]=128
#gameArray[2,4]=32
#gameArray[3,2]=2
#gameArray[4,1]=4


#for ((a=1; a <= 10 ; a++))
#do
#    setRandTile
#done
