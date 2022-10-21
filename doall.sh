export CPLUS_INCLUDE_PATH=${PWD}/testlib

g++ "${1}/gen.cpp" -Wall -std=c++17 -o gen

echo generator compiled

g++ "${1}/std.cpp" -Wall -std=c++17 -O2 -o std

echo std compiled

mkdir -p "${1}/tests"

cnt=1
while read i
do
echo ""
echo "==== Test Case #${cnt}"
echo "param: ${i}"
./gen $i > "${1}/tests/${cnt}.in"
time ./std < "${1}/tests/${cnt}.in" > "${1}/tests/${cnt}.out"
cnt=`expr ${cnt} + 1` 
done < "${1}/scripts.in"

cnt=1
while read i
do
echo ""
echo "==== Sample Test Case #${cnt}"
echo "param: ${i}"
./gen $i > "${1}/tests/${1}${cnt}.in"
time ./std < "${1}/tests/${1}${cnt}.in" > "${1}/tests/${1}${cnt}.out"
cnt=`expr ${cnt} + 1` 
done < "${1}/samples.in"