# bash-humanize
A simple bash script the humanizes the elapsed time from now.

#example usage

```
$>./bash-humanize.sh $(( $(date +%s) - 84602 ))
23 hours 30 minutes 2 seconds ago
```

```
$./bash-humanize.sh 1471357530
4 hours 26 minutes 31 seconds ago
```

```
$./bash-humanize.sh
now
```
