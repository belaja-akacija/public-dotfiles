//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
  /*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
  { "",      "playing.sh"                                                  , 1 , 0 },
  { "",      "uptime.sh"                                                   , 1 , 0 },
  { "Upd: ", "checkupdates | wc -l"                                        , 30, 0 },
  {"", "~/Documents/scripts/statusbar/sb-internet.sh", 5, 4},
  { "",      "sensors | grep 'Package id 0:' | awk '{print substr($4,2)}'" , 20, 0 },
  {"Mem: ",  "free -h | awk '/^Mem/ { print $7\"/\"$2 }' | sed s/i//g"     , 10, 0 },
  {"Disk: ", "df -h /dev/sda3 | awk '/dev/ { print $4 }'"                  , 60, 0 },
  { "",      "battery-stat.sh"                                             , 10, 0 },
  {"",       "date '+%b %d (%a) %R'"                                       , 60, 0 }
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
