#!/usr/bin/env bash
#this is a bash script for comparing 2 differents command with time command, if your trying to use it with application don't its only for commands


#colors!!!!!!!!

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
YELLOW="\033[1;33m"
RESET="\033[0m"

#variables and functions

help ()
{
    echo -e "${CYAN}Time Comparison Script${RESET}"
    echo -e "Compare the execution time of two commands."
    echo -e "\n${YELLOW}Usage:${RESET}"
    echo -e "  ./timecomp.sh [options]\n"
    echo -e "${YELLOW}Options:${RESET}"
    echo -e "  ${GREEN}-h, --help${RESET}         Show this help message."
    echo -e "  ${GREEN}-v, --version${RESET}      Display the script version."
    echo -e "  ${GREEN}-a, --arg${RESET}          Specify two commands to compare (e.g., ${CYAN}-a \"command1\" \"command2\"${RESET})."
    echo -e "  ${GREEN}-r, --read${RESET}         Prompt user to input commands for comparison during script execution."
    echo -e "\n${YELLOW}Examples:${RESET}"
    echo -e "  ./timecomp.sh -a \"ls -l\" \"find . -type f\""
    echo -e "  ./timecomp.sh -r"
}

comparison ()
{
    local cmd1="$1"
    local cmd2="$2"

    echo -e "${BLUE}=====================================${RESET}"
    echo -e "${YELLOW}           Command: $cmd1${RESET}"
    echo -e "${BLUE}=====================================${RESET}"
    comp1=$( (time $cmd1) 2>&1 | grep -E "real|user|sys")
    echo -e "$comp1"

    echo -e "${BLUE}=====================================${RESET}"
    echo -e "${YELLOW}           Command: $cmd2${RESET}"
    echo -e "${BLUE}=====================================${RESET}"
    comp2=$( (time $cmd2) 2>&1 | grep -E "real|user|sys")
    echo -e "$comp2"
    echo -e "${BLUE}=====================================${RESET}" 
    echo -e "${GREEN}Comparison completed.${RESET}"
    echo -e "${BLUE}=====================================${RESET}"
}

comp1=""
comp2=""

#argument

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      help
      shift # past argument
      shift # past value
      ;;
    -a*|--arg*)
      if [[ $# -lt 3 ]]; then
        echo "Error: -a|--arg requires two commands as arguments."
        echo "Usage: ./timecomp.sh -a \"command1\" \"command2\""
        exit 1
      fi
      #using $1 and $2 results "command -a not found" I don't know why, ok I fixed it by changing $1 to $2 and $2 to $3(i wish i did) yippie it did work
      comparison "$2" "$3"
      shift
      shift
      ;;
    -r|--read)
      echo -e "${YELLOW}Enter the first command:${RESET}"
      read -r cmd1
      echo -e "${YELLOW}Enter the second command:${RESET}"
      read -r cmd2
      comparison "$cmd1" "$cmd2" 
      shift
      ;;
    -*|--*)
      echo -e "${RED}Unknown option:${RESET} $1. Use -h or --help for usage information." 
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") 
      shift
      ;;
  esac
done
