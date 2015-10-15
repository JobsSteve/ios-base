61. Скрипты. Scripts
==

##Скрипт для инкрементирования билда

`Target` > `Build Phases` > `+` > `Run Script` > Наименуем как: `Increment Build Version Run Script`

```objc
releaseConfig="Release"
if [ "$releaseConfig" = "${CONFIGURATION}" ]; then
echo incrementing build ver
buildNumber=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "${PROJECT_DIR}/${INFOPLIST_FILE}")
buildNumber=$(($buildNumber + 1))
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "${PROJECT_DIR}/${INFOPLIST_FILE}"
fi
```



