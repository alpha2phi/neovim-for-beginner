if filereadable("./gradlew")
    let test#java#runner = 'gradletest'
    let test#java#gradletest#executable = './gradlew --parallel test'
    setlocal makeprg=./gradlew\ --no-daemon\ -q
else
    setlocal makeprg=gradle\ --no-daemon\ -q
endif

setlocal path=.,src/main/java/**,src/test/java/**,**/src/main/java/**,**/src/test/java/**
setlocal include=^\s*import
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
