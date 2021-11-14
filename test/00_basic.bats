#!/usr/bin/env bats

readonly lup=$BATS_TEST_DIRNAME/../lup
readonly tmpdir=$BATS_TEST_DIRNAME/../tmp
readonly stdout=$BATS_TEST_DIRNAME/../tmp/stdout
readonly stderr=$BATS_TEST_DIRNAME/../tmp/stderr
readonly exitcode=$BATS_TEST_DIRNAME/../tmp/exitcode

setup() {
  if [[ $BATS_TEST_NUMBER == 1 ]]; then
    mkdir -p -- "$tmpdir"
  fi
}

teardown() {
  if [[ ${#BATS_TEST_NAMES[@]} == $BATS_TEST_NUMBER ]]; then
    rm -rf -- "$tmpdir"
  fi
}

check() {
  printf "%s\n" "" > "$stdout"
  printf "%s\n" "" > "$stderr"
  printf "%s\n" "0" > "$exitcode"
  "$@" > "$stdout" 2> "$stderr" || printf "%s\n" "$?" > "$exitcode"
}

@test 'lup: read stdin if no arguments passed' {
  src=$(printf "%s\n" $'
  1 100 10000
  100 10000 1
  10000 1 100
  ' | sed -e '1d' -e 's/^  //')
  dst=$(printf "%s\n" $'
  1     100   10000
  100   10000 1
  10000 1     100
  ' | sed -e '1d' -e 's/^  //')
  check "$lup" <<< "$src"
  [[ $(cat "$exitcode") == 0 ]]
  [[ $(cat "$stdout") == $dst ]]
}

@test 'lup: read files if files passed' {
  src1=$(printf "%s\n" $'
  name = Duress
  ' | sed -e '1d' -e 's/^  //')
  src2=$(printf "%s\n" $'
  type_line = Sorcery
  ' | sed -e '1d' -e 's/^  //')
  dst=$(printf "%s\n" $'
  name      = Duress
  type_line = Sorcery
  ' | sed -e '1d' -e 's/^  //')
  check "$lup" <(echo "$src1") <(echo "$src2")
  [[ $(cat "$exitcode") == 0 ]]
  [[ $(cat "$stdout") == $dst ]]
}

@test 'lup: print error if nonexistent file passed' {
  check "$lup" ctcE4_S_c4IsW5JZaxtuaahC7sLb1cWGT9lslCRn
  [[ $(cat "$exitcode") == 1 ]]
  [[ $(cat "$stderr") =~ ^'lup: Can'"'"'t open' ]]
}

@test 'lup: print usage if --help' {
  check "$lup" --help
  [[ $(cat "$exitcode") == 0 ]]
  [[ $(cat "$stdout") =~ ^usage ]]
}

@test 'lup: print error if unkown option passed' {
  check "$lup" --test
  [[ $(cat "$exitcode") == 1 ]]
  [[ $(cat "$stderr") =~ ^'lup: Unknown option' ]]
}

@test 'lup: separate lines only COUNT times if -c passed' {
  src=$(printf "%s\n" $'
  1 100 10000
  100 10000 1
  10000 1 100
  ' | sed -e '1d' -e 's/^  //')
  dst=$(printf "%s\n" $'
  1     100 10000
  100   10000 1
  10000 1 100
  ' | sed -e '1d' -e 's/^  //')
  check "$lup" -c1 <<< "$src"
  [[ $(cat "$exitcode") == 0 ]]
  [[ $(cat "$stdout") == $dst ]]
}

@test 'lup: separate lines only COUNT times if --count passed' {
  src=$(printf "%s\n" $'
  1 100 10000
  100 10000 1
  10000 1 100
  ' | sed -e '1d' -e 's/^  //')
  dst=$(printf "%s\n" $'
  1     100 10000
  100   10000 1
  10000 1 100
  ' | sed -e '1d' -e 's/^  //')
  check "$lup" --count 1 <<< "$src"
  [[ $(cat "$exitcode") == 0 ]]
  [[ $(cat "$stdout") == $dst ]]
}

@test 'lup: keep the first indent as indents if -i passed' {
  src=$(printf "%s\n" $'
  \t1 100 10000
  \t100 10000 1
  \t\t10000 1 100
  ' | sed -e '1d' -e 's/^  //')
  dst=$(printf "%s\n" $'
  \t1     100   10000
  \t100   10000 1
  \t10000 1     100
  ' | sed -e '1d' -e 's/^  //')
  check "$lup" -i <<< "$src"
  [[ $(cat "$exitcode") == 0 ]]
  [[ $(cat "$stdout") == $dst ]]
}

@test 'lup: keep the first indent as indents if --keep-indent passed' {
  src=$(printf "%s\n" $'
  \t1 100 10000
  \t100 10000 1
  \t\t10000 1 100
  ' | sed -e '1d' -e 's/^  //')
  dst=$(printf "%s\n" $'
  \t1     100   10000
  \t100   10000 1
  \t10000 1     100
  ' | sed -e '1d' -e 's/^  //')
  check "$lup" --keep-indent <<< "$src"
  [[ $(cat "$exitcode") == 0 ]]
  [[ $(cat "$stdout") == $dst ]]
}

@test 'lup: separate lines by SEP if -s passed' {
  src=$(printf "%s\n" $'
  name=Duress
  cmc=   1
  type_line = Sorcery
  rarity  =common
  ' | sed -e '1d' -e 's/^  //')
  dst=$(printf "%s\n" $'
  name      = Duress
  cmc       = 1
  type_line = Sorcery
  rarity    = common
  ' | sed -e '1d' -e 's/^  //')
  check "$lup" -s= <<< "$src"
  [[ $(cat "$exitcode") == 0 ]]
  [[ $(cat "$stdout") == $dst ]]
}

@test 'lup: separate lines by SEP if --separator passed' {
  src=$(printf "%s\n" $'
  name=Duress
  cmc=   1
  type_line = Sorcery
  rarity  =common
  ' | sed -e '1d' -e 's/^  //')
  dst=$(printf "%s\n" $'
  name      = Duress
  cmc       = 1
  type_line = Sorcery
  rarity    = common
  ' | sed -e '1d' -e 's/^  //')
  check "$lup" --separator = <<< "$src"
  [[ $(cat "$exitcode") == 0 ]]
  [[ $(cat "$stdout") == $dst ]]
}

# vim: ft=bash
