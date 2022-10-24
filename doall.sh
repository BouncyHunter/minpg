export CPLUS_INCLUDE_PATH=${PWD}/testlib

mkdir -p build

g++ "${1}/gen.cpp" -Wall -std=c++17 -o build/gen

echo generator compiled

g++ "${1}/std.cpp" -Wall -std=c++17 -O2 -o build/std

echo std compiled

mkdir -p "${1}/tests"

cnt=1
while read i
do
echo ""
echo "==== Test Case #${cnt}"
echo "param: ${i}"
./build/gen $i > "${1}/tests/${cnt}.in"
time ./build/std < "${1}/tests/${cnt}.in" > "${1}/tests/${cnt}.out"
cnt=`expr ${cnt} + 1` 
done < "${1}/scripts.in"

cnt=1
while read i
do
echo ""
echo "==== Sample Test Case #${cnt}"
echo "param: ${i}"
./build/gen $i > "${1}/tests/${1}${cnt}.in"
time ./build/std < "${1}/tests/${1}${cnt}.in" > "${1}/tests/${1}${cnt}.out"
cnt=`expr ${cnt} + 1` 
done < "${1}/samples.in"